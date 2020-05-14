<?php
// fetch data
$today = json_decode(file_get_contents('https://corona.lmao.ninja/v2/countries/morocco'));
$yesterday = json_decode(file_get_contents('https://corona.lmao.ninja/v2/countries/morocco?yesterday=true'));

// append today recovers info
$today->TodayRecovers = ($today->recovered - $yesterday->recovered);

// cases icons data
$today->casesIcon = ($today->todayCases > $yesterday->todayCases) ? true : false;

//need corrections!!
$today->recoversIcon = ($today->recovered > $yesterday->recovered) ? true : false;

// death icons data
$today->deathsIcon = ($today->todayDeaths > $yesterday->todayDeaths) ? true : false;

// show new object
echo json_encode($today);

