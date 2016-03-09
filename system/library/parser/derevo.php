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
        $this->product_object = new stdClass();

        $this->product_object->meta_description = trim($this->html->find("meta[name='description']", 0)->content);

        $this->product_object->product_title = trim($this->html->find('h1', 0)->plaintext);
        $this->product_object->sku = trim($this->html->find('div.sku', 0)->plaintext);

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
        $this->product_object->attributes = $product_property;

        $this->product_object->product_description = $this->html->find('div.product-description', 0)->plaintext;

        $this->product_object->product_images[] = $this->html->find('div.main-image img', 0)->getAttribute('src');

        foreach($this->html->find('div.additional-images img') as $li_item){
            $this->product_object->product_images[] = trim($li_item->getAttribute('src'));
        }

        foreach($this->html->find('ul.breadcrumb a.pathway') as $li_item){
            $this->product_object->breadcrumbs[] = trim($li_item->childNodes(0)->plaintext);
        }
    }


    public function get_product_info(){
        $this->fetch_product_data();

        $product_info['title'] = $this->product_object->product_title;
        $product_info['short_description'] = $this->product_object->meta_description;
        $product_info['description'] = $this->product_object->product_description;
        $product_info['images'] = $this->product_object->product_images;
        $product_info['unit_price'] = 0;
        $product_info['attributes'] = $this->product_object->attributes;

        return $product_info;
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