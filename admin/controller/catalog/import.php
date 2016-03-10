<?php
header('Content-Type: text/html; charset=UTF-8');


define('CATEGORY_MOBILE', 59);
define('CATEGORY_SMART_WATCHES', 60);

class ControllerCatalogImport extends Controller {
	public function index() {
		$this->load->library('parser/derevo');

		$this->load->model('catalog/category');
		$this->load->model('catalog/product');

		$parser = new derevo();

		$parser->get_page_content('http://4derevo.ru/katalog/results,1-2000.html?categorylayout=0&showcategory=0&showproducts=1&productsublayout=0');
		$parser->fetch_products_from_category();

		foreach($parser->get_all_products_per_category() as $product_href){
			$parser->get_page_content('http://4derevo.ru' . $product_href);
			$info = $parser->get_product_info();
			var_dump($info);die;
		}

		#Let's scan for sub_categories per each category
		$sub_categories_to_scan = array();
		foreach($category_page_urls as $parent_category_id => $page_url){
			$parser->get_page_content($page_url);
			$parser->fetch_sub_categories();
			if($sub_categories = $parser->get_sub_categories()){
				#sync categories with local site
				foreach($sub_categories as $category){
					$remote_id = trim(basename($category['href']));
					if($remote_id) {
						$category_exist = $this->model_catalog_category->getCategoryByRemoteID($remote_id);
						#lets create new category
						if(empty($category_exist)){
							$add_category_data = array();
							$add_category_data['category_description'][1] = array(
								'name' => trim($category['text']),
								'description' => '',
								'meta_title' => trim($category['text']),
								'meta_description' => '',
								'meta_keyword' => '',
							);

							$add_category_data['path'] = '';
							$add_category_data['parent_id'] = $parent_category_id;
							$add_category_data['filter'] = '0';
							$add_category_data['category_store'][0] = 0;
							$add_category_data['keyword'] = '';
							$add_category_data['image'] = '';
							$add_category_data['column'] = '1';
							$add_category_data['sort_order'] = '0';
							$add_category_data['status'] = '0';
							$add_category_data['category_layout'][0] = '0';
							$add_category_data['remote_id'] = $remote_id;
							$category_id = $this->model_catalog_category->addCategory($add_category_data);
						}else{
							$category_id = $category_exist['category_id'];
						}
						$sub_categories_to_scan[$category_id] = $category['href'];
					}else{
						echo "Category ID invalid";exit;
					}
				}

			}else{
				$sub_categories_to_scan[$parent_category_id] = $page_url;
			}
		}
		#ok on this stage we have associative array of category_id => url_to_scan
		#next step is to get products!
		$parser = new derevo();

		foreach($sub_categories_to_scan as $category_id => $category_page_url){
			$parser->clear_category_products_list();

			$page_no = 1;
			$page = $category_page_url . $page_no.".html/?page_size=120";
			$parser->get_page_content($page);

			$total_products = $parser->get_total_products_per_category();

			$total_pages = round($total_products / 120)+1;
			while($page_no <= $total_pages){
				$page = $category_page_url . $page_no.".html?page_size=120";
				$parser->get_page_content($page);
				$parser->fetch_products_from_category();
				$page_no++;
#				sleep(1);
			}
			$products_list = $parser->get_all_products_per_category();

			if(!empty($products_list)){
                echo "Syncing ".count($products_list)." products for ".$category_page_url.PHP_EOL;

				foreach($products_list as $product_href){
					$remote_id = trim(str_replace('.html', '', basename($product_href)));
					$parser->get_page_content($product_href);
					$product_info = $parser->get_product_info();

					if(!empty($product_info['images'])){
						$images_path = DIR_IMAGE.'catalog/goods-images/';
						foreach($product_info['images'] as &$value){
							$filename = basename($value);

							if(!file_exists($images_path . $filename) || !filesize($images_path . $filename)){
								$status = $parser->grab_image($value, $images_path . $filename);
								if($status){
									$value = 'catalog/goods-images/'.$filename;
								}else{
									$value = false;
								}
							}else{
								$value = 'catalog/goods-images/'.$filename;
							}
						}
					}

					$product_record = $this->model_catalog_product->getProductByRemoteId($remote_id);

					if(empty($product_record)){
						$add_product = array();
						$add_product['product_description'][1] = array(
							'name' => $product_info['title'],
							'description' => $product_info['description'],
							'meta_title' => $product_info['short_description'],
							'meta_description' => '',
							'meta_keyword' => '',
							'tag' => ''
						);
						$add_product['image'] = isset($product_info['images'][0])?$product_info['images'][0]:'';
						$add_product['model'] = $remote_id;
						$add_product['sku'] = '';
						$add_product['upc'] = '';
						$add_product['ean'] = '';
						$add_product['jan'] = '';
						$add_product['isbn'] = '';
						$add_product['mpn'] = '';
						$add_product['location'] = '';
						$add_product['price'] = round(1.2 * (float)$product_info['unit_price'], 2);
						$add_product['tax_class_id'] = '';
						$add_product['quantity'] = '1000';
						$add_product['minimum'] = '1';
						$add_product['subtract'] = '0';
						$add_product['stock_status_id'] = '7';
						$add_product['shipping'] = '1';
						$add_product['keyword'] = '';
						$add_product['date_available'] = date('Y-m-d');
						$add_product['length'] = '0';
						$add_product['width'] = '0';
						$add_product['height'] = '0';
						$add_product['length_class_id'] = '1';
						$add_product['weight'] = '0';
						$add_product['weight_class_id'] = '2';

						$add_product['status'] = '1';
						$add_product['sort_order'] = '1';
						$add_product['manufacturer'] = '0';
						$add_product['manufacturer_id'] = '0';
						$add_product['category'] = $category_id;
						$add_product['filter'] = '0';
						$add_product['product_store'] = array(0);
						$add_product['download'] = '';
						$add_product['related'] = '';
						$add_product['option'] = '';

						if(!empty($product_info['images'])){
                            $img_array = array();
							foreach($product_info['images'] as $product_img){
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
						$add_product['remote_id'] = $remote_id;

						$product_id = $this->model_catalog_product->addProduct($add_product);
					}else{
                        $product_id = $product_record['product_id'];

                        $product_record['product_description'][1] = array(
                            'name' => $product_info['title'],
                            'description' => $product_info['description'],
                            'meta_title' => $product_info['short_description'],
                            'meta_description' => '',
                            'meta_keyword' => '',
                            'tag' => ''
                        );

                        if(!empty($product_info['images'])){
                            foreach($product_info['images'] as $product_img){
                                $img_array[] = array(
                                    'image' => $product_img,
                                    'sort_order' => '0'
                                );
                            }
                            $product_record['product_image'] = $img_array;
                        }

                        $product_record['price'] = round(1.2 * (float)$product_info['unit_price'], 2);
                        $this->model_catalog_product->editProduct($product_id, $product_record);
					}
				}
                echo "--- Syncing done.".PHP_EOL;
			}
		}
	}

	public function add() {
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_category->addCategory($this->request->post);
		}
	}

	public function edit() {

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_category->editCategory($this->request->get['category_id'], $this->request->post);
		}
	}

}
