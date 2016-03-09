<?php
/**
 * Created by PhpStorm.
 * User: sbushinskii
 * Date: 2/22/16
 * Time: 8:24 PM
 */
header('Content-Type: text/html; charset=UTF-8');
error_reporting(E_ALL);

require_once 'library/gearbest_parser.php';

$parser = new gearbest_parser();

//$parser->get_page_content('http://4derevo.ru/katalog/results,1-504.html?categorylayout=0&showcategory=0&showproducts=1&productsublayout=0');
$parser->get_page_content('http://4derevo.ru/katalog/results,1-2.html?categorylayout=0&showcategory=0&showproducts=1&productsublayout=0');
$parser->fetch_products_from_category();

foreach($parser->get_all_products_per_category() as $product_href){
    $parser->get_page_content('http://4derevo.ru' . $product_href);
    $info = $parser->get_product_info();

}
