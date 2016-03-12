<?php

/**
 * Created by PhpStorm.
 * User: sbushinskii
 * Date: 2/22/16
 * Time: 9:02 PM
 */
ini_set('max_execution_time',0);
ini_set('memory_limit', '128M');

require_once 'simple_html_dom.php';

class derevo {

    public $html;
    private $product_object;

    private $category_sub_items;
    private $category_products = array();

    public function clear_category_products_list(){
        $this->category_products = array();
    }

    function grab_file($url, $saveto){
        $content = file_get_contents($url);
        $fp = fopen($saveto, "w");
        fwrite($fp, $content);
        fclose($fp);

        if(file_exists($saveto) && filesize($saveto) > 1){
            return true;
        }else{
            echo "Failed to dl file! ".$url."<br>";
            return false;
        }
    }


    public function get_page_content($page_url){
        $this->html = '';
        $this->product_object = '';
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $page_url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 10);
        $str = curl_exec($curl);
        curl_close($curl);
        $this->html = str_get_html($str);
    }

    public function fetch_product_data(){
        $attribute_id = array();
        $attribute_id['Размер сборки'] = 12;
        $attribute_id['Количество элементов'] = 13;
        $attribute_id['Количество элементов'] = 15;
        $attribute_id['Материал'] = 16;
        $attribute_id['Упаковка'] = 17;


        $this->product_object = new stdClass();

        $this->product_object->meta_description = trim($this->html->find("meta[name='description']", 0)->content);

        $this->product_object->product_title = trim($this->html->find('h1', 0)->plaintext);
        $sku_tmp = trim($this->html->find('div.sku', 0)->plaintext);
        $sku_tmp = explode(':', $sku_tmp);
        $this->product_object->sku = trim($sku_tmp[1]);

        //Dimensions
        // Parse property names
        foreach($this->html->find('div.dimensions span.product-fields-title') as $product_field){
            $attribute_names_d[] = trim($product_field->plaintext);
        }
        // Parse property values
        foreach($this->html->find('div.dimensions div.product-field-display') as $product_field){
            $attribute_value_d[] = trim($product_field->plaintext);
        }
        // Combine names and properties
        foreach($attribute_names_d as $key => $attr_name){
            $product_property_dimensions[$attr_name] = $attribute_value_d[$key];
        }
        $this->product_object->weight = $attribute_value_d[0];

        $tmp_dimension = $attribute_value_d[1];
        $tmp_arr = explode('x', $tmp_dimension);

        $dimensions['length'] = floatval(trim($tmp_arr[0]));
        $dimensions['width'] = floatval(trim($tmp_arr[1]));
        $dimensions['height'] = floatval(trim($tmp_arr[2]));
        $this->product_object->dimensions = $dimensions;

        //Other properties
        //Other properties
        // Parse property names
        foreach($this->html->find('div.product-fields div.product-field span.product-fields-title') as $product_field){
            $attribute_names[] = trim($product_field->plaintext);
        }
        // Parse property values
        foreach($this->html->find('div.product-fields div.product-field div.product-field-display') as $product_field){
            $attribute_value[] = trim($product_field->plaintext);
        }
        // Combine names and properties
        foreach($attribute_names as $key => $attr_name){
            $product_property[$attr_name] = $attribute_value[$key];
        }


        foreach($product_property as $attr_name => $attr_value){
            $attr_name = str_replace(':', '', $attr_name);

            $attr_id = $attribute_id[$attr_name];
            $product_attributes[] = array(
                'name' => $attr_name,
                'attribute_id' => $attr_id,
                'product_attribute_description' => array('1' => array('text'=>$attr_value)),
            );
        }
        $this->product_object->attributes = $product_attributes;

        $this->product_object->product_description = trim($this->html->find('div.product-description', 0)->plaintext);

        $this->product_object->product_images[] = $this->html->find('div.main-image img', 0)->getAttribute('src');

        foreach($this->html->find('div.additional-images img') as $li_item){
            $this->product_object->product_images[] = trim($li_item->getAttribute('src'));
        }
    }


    public function get_product_info(){
        $this->fetch_product_data();
        return $this->product_object;
    }

    /*** CATEGORY PARSER ***/

    public function fetch_sub_categories(){
        $this->category_sub_items = array();
        if($sub_categories = @$this->html->find('section.subCatAttr a')) {
            foreach ($sub_categories as $sub_category) {
                $item['text'] = $sub_category->innertext;
                $item['href'] = $sub_category->href;
                $this->category_sub_items[] = $item;
            }
        }
    }

    public function fetch_products_from_category(){
        foreach($this->html->find('div.product-box a') as $product_item){
            $this->category_products[] = $product_item->href;
        }
    }

    public function get_all_products_per_category(){
        return $this->category_products;
    }

    public function get_sub_categories(){
        return $this->category_sub_items;
    }

    public function get_total_products_per_category(){
        @$total_text = trim($this->html->find('div.perPage p', 0)->innertext);
        if(!$total_text){
            return 0;
        }
        $tmp = explode(' ', $total_text);
        return $tmp[0];

    }
}