<?php
function get_url($url)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, 9);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    $tmp = curl_exec($ch);
    print_r(curl_getinfo($ch));
    curl_close($ch);
    return $tmp;
}

$url = "http://54.202.32.162/api/v2/suggestions";
echo "starting curl of {$url}";

get_url($url);
