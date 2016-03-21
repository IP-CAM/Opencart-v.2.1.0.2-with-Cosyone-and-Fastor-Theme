<?php

function get_stat($url, $headers) {
  $handle = curl_init();
  curl_setopt($handle, CURLOPT_URL, $url);
  curl_setopt($handle, CURLOPT_HTTPHEADER, $headers);
  curl_setopt($handle, CURLOPT_SSL_VERIFYPEER, false);
  curl_setopt($handle, CURLOPT_SSL_VERIFYHOST, false);
  curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
  $response = curl_exec($handle);
  $code = curl_getinfo($handle, CURLINFO_HTTP_CODE);
  return array("code" => $code, "response" => $response);
}

function download_file($source, $article) {
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, $source);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_SSLVERSION,3);
  $data = curl_exec ($ch);
  $error = curl_error($ch);
  curl_close ($ch);

var_dump($source);die;

  $destination = "./files/".$article;

  $file = fopen($destination, "w");
  fputs($file, $data);
  fclose($file);
}

function get_urls() {
  $urls = array();
  if (($handle = fopen("catalog.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
      $yandex_url = $data[16];
      $article = $data[3];
      if (substr_count($yandex_url, 'http')) {
        $urls[$article] = $yandex_url;
      }
    }
    fclose($handle);
  }
  return $urls;
}

$urls = get_urls();

foreach ($urls as $article => $url_yandex_disk) {
  $result = get_stat("https://cloud-api.yandex.net:443/v1/disk/public/resources/download?public_key=" . urlencode($url_yandex_disk), array());

  if ($result["code"] == 200) {
    $result["response"] = json_decode($result["response"], true);
  ?>
    <a target="_blank" href="<?php echo $result["response"]['href'];?>"><?php echo $article;?></a><br>
<?php
  }
  else {
    echo "error" . PHP_EOL;
  }
}
?>

https://downloader.disk.yandex.ru/disk/fa2bb11ea0fc4a65b298f6e13aa99591c211c3094ea8c735ff320de043828214/56eafdaa/MMekstTOtHpBNz9StuFuV8Fa-2gj7vSMg9so5cfTuWG0gnsXvrR7c2_q-FnzIFggcfFhP2PUE5Ngb4X-dlRTgQ==?uid=0&filename=23544TS Игр.Калейдоскоп История игрушек.jpg&disposition=attachment&hash=CF9lN7MhGRw7JayyIg1Bx3PwPVTvffRqD4w6QM2qEXo=:&limit=0&content_type=image/jpeg&fsize=82266&hid=f8acccba04d18f24d9d9f1a393704b65&media_type=image&tknv=v2