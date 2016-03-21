<?php
header('Content-Type: text/html; charset=UTF-8');



class ControllerCatalogImport extends Controller
{

	function add_product($parser, $product_info, $category_id)
	{
		if (!empty($product_info->product_images)) {
			$images_path = DIR_IMAGE . 'catalog/goods-images/';
			foreach ($product_info->product_images as &$value) {
				$filename = basename($value);
				$value = 'http://4derevo.ru'.$value;

				if (!file_exists($images_path . $filename) || !filesize($images_path . $filename)) {
					$status = $parser->grab_file($value, $images_path . $filename);
					if ($status) {
						$value = 'catalog/goods-images/' . $filename;
					} else {
						$value = false;
					}
				} else {
					$value = 'catalog/goods-images/' . $filename;
				}
			}
		}

		$product_record = $this->model_catalog_product->getProductBySKU($product_info->sku);

		if (empty($product_record)) {
			$add_product = array();

			$meta_desc = array();
			$meta_desc[] = $product_info->product_title;
			$meta_desc[] = $product_info->sku;
			$meta_desc[] = 'Омск, деревянные 3D пазлы, чудо дерево, модели из дерева';

			$add_product['product_description'][1] = array(
				'name' => $product_info->product_title,
				'description' => $product_info->product_description,
				'meta_title' => $product_info->title,
				'meta_description' => $product_info->meta_description,
				'meta_keyword' => implode(',', $meta_desc),
				'tag' => '0'
			);
			$add_product['image'] = isset($product_info->product_images[0]) ? $product_info->product_images[0] : '';
			$add_product['model'] = $product_info->sku;
			$add_product['sku'] = $product_info->sku;
			$add_product['upc'] = '';
			$add_product['ean'] = '';
			$add_product['jan'] = '';
			$add_product['isbn'] = '';
			$add_product['mpn'] = '';
			$add_product['location'] = '';
			$add_product['price'] = 0;
			$add_product['tax_class_id'] = '';
			$add_product['quantity'] = '0';
			$add_product['minimum'] = '1';
			$add_product['subtract'] = '0';
			$add_product['stock_status_id'] = '7';
			$add_product['shipping'] = '1';
			$add_product['keyword'] = '';
			$add_product['date_available'] = date('Y-m-d');

			$add_product['length'] = $product_info->dimensions['length'];
			$add_product['width'] = $product_info->dimensions['width'];
			$add_product['height'] = $product_info->dimensions['height'];

			$add_product['length_class_id'] = '1';
			$add_product['weight'] = floatval($product_info->weight);
			$add_product['weight_class_id'] = '1';

			$add_product['manufacturer_id'] = 11;
			$add_product['main_category_id'] = $category_id;
			$add_product['product_category']['0'] = $category_id;

			$add_product['status'] = '0';
			$add_product['sort_order'] = '1';
			$add_product['manufacturer'] = 'Чудо-Дерево';
			$add_product['category'] = 0;
			$add_product['filter'] = '0';
			$add_product['product_store'] = array(0);
			$add_product['download'] = '';
			$add_product['related'] = '';
			$add_product['option'] = '';

			$add_product['product_attribute'] = $product_info->attributes;

			if (!empty($$product_info->product_images)) {
				$img_array = array();
				foreach ($product_info->product_images as $product_img) {
					$img_array[] = array(
						'image' => $product_img,
						'sort_order' => '0'
					);
				}
				$add_product['product_image'] = $img_array;
			}
			$add_product['points'] = '';
			$add_product['product_reward'][1]['points'] = '';
			$add_product['product_layout'][0] = '';
			$add_product['points'] = 0;

			$product_id = $this->model_catalog_product->addProduct($add_product);
			if(!$product_id){
				var_dump($add_product);die;
			}
			return $product_id;
		}
		echo "exists<br>";
	}

	function grabInstructions(){
		$this->load->library('parser/derevo');
		$parser = new derevo();

		$counter1 = 0;
		$counter2 = 0;

		$folder = 'http://4derevo.by/Download/insrtruktion/';
		$folder3D = 'http://4derevo.by/Download/insrtruktion3D/';

		$this->load->model('catalog/product');
		$skus = $this->model_catalog_product->getAllSkus();
		foreach($skus as $sku){

			$sku = strtoupper($sku['sku']);
			$pdf_1 = $folder . $sku . '.pdf';
			$pdf_2 = $folder3D . $sku . '.pdf';

			$counter1 = $counter1 + ($parser->grab_file($pdf_1, DIR_DOWNLOAD .'manual/' . $sku . '.pdf'))?1:0;
			$counter2 = $counter2 + ($parser->grab_file($pdf_2, DIR_DOWNLOAD .'manual3D/' . $sku . '.pdf'))?1:0;

		}
		echo "Grabbed normal: ".$counter1;
		echo "<br>";
		echo "Grabbed 3D: ".$counter2;
		die;
	}

	public function index()
	{
		$this->load->library('parser/derevo');

		$this->load->model('catalog/category');
		$this->load->model('catalog/product');

		$parser = new derevo();
		//$all_url = 'http://4derevo.ru/katalog/results,1-2000.html?categorylayout=0&showcategory=0&showproducts=1&productsublayout=0';

		$category_id = 87;
		$name = 'chasy-sbornye-modeli.';

		$scan_url = 'http://4derevo.ru/katalog/'.$name.'/results,1-150.html';

		$parser->get_page_content($scan_url);
		$parser->fetch_products_from_category();

		foreach ($parser->get_all_products_per_category() as $product_href) {
			$parser->get_page_content('http://4derevo.ru' . $product_href);
			$info = $parser->get_product_info();
			$status = $this->add_product($parser, $info, $category_id);
			if($status){
				echo "Nice.<br>";
			}else{
				echo "Not Nice.<br>";
			}
		}
	}

	public function sync_csv(){
		$products = $this->parse_csv();

		$this->load->model('catalog/product');

		foreach($products as $product_item){
			$product_record = $this->model_catalog_product->getProductBySKU($product_item['sku']);
			if (empty($product_record)) {
				$this->model_catalog_product->addProduct($product_item);
			}else{
				$this->model_catalog_product->updateProductDefaultPrice($product_record['product_id'], $product_item['default_price']);
			}
		}
	}

	/**
	 * Parse XSL (converted to CSV manually)
	 *
	 * @return array
	 */
	private function parse_csv() {
		$products = array();
		if (($handle = fopen(DIR_APPLICATION . "../tmp/catalog.csv", "r")) !== FALSE) {
			$row = 0;
			while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
				if($row > 0) {
					$products[] = $this->populate_product_record($data);
				}
				$row++;
			}
			fclose($handle);
		}
		echo "XLS files amount: ".$row."<br>";
		return $products;
	}

	private function populate_product_record($product_info){
		$add_product = array();
		$product_name = explode(' ', $product_info[5]);
		array_shift($product_name);
		$product_name = implode(' ', $product_name);

		$add_product['product_description'][1] = array(
			'name' => "* imported * ".$product_name,
			'description' => $product_info[16],
			'meta_title' => $product_info[14],
			'meta_description' => '',
			'meta_keyword' => '',
			'tag' => ''
		);
		$add_product['image'] = '';
		$add_product['model'] = $product_info[3];
		$add_product['sku'] = $product_info[3];
		$add_product['upc'] = '';
		$add_product['ean'] = '';
		$add_product['jan'] = '';
		$add_product['isbn'] = $product_info[4];
		$add_product['mpn'] = '';
		$add_product['location'] = '';
		$add_product['price'] = round($product_info[6] * 1.45 , 2);
		$add_product['default_price'] = $product_info[6];
		$add_product['my_purchase_price'] = $product_info[6];
		$add_product['tax_class_id'] = '9';
		$add_product['quantity'] = '0';
		$add_product['minimum'] = '1';
		$add_product['subtract'] = '0';
		$add_product['stock_status_id'] = '8';
		$add_product['shipping'] = '1';
		$add_product['keyword'] = '';
		$add_product['date_available'] = date('Y-m-d');
		$add_product['length'] = '0';
		$add_product['width'] = '0';
		$add_product['height'] = '0';
		$add_product['length_class_id'] = '1';
		$add_product['weight'] = $product_info['11'];
		$add_product['weight_class_id'] = '1';
		$add_product['status'] = '0';
		$add_product['sort_order'] = '1';
		$add_product['manufacturer'] = 'Чудо-Дерево';
		$add_product['manufacturer_id'] = '11';
		$add_product['category'] = 0;
		$add_product['filter'] = '0';
		$add_product['product_store'] = array(0);
		$add_product['download'] = '';
		$add_product['related'] = '';
		$add_product['option'] = '';

		$add_product['points'] = '';
		$add_product['product_reward'][1]['points'] = '';
		$add_product['product_layout'][0] = '';

		return $add_product;
	}


}