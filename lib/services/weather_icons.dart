import 'package:flutter/material.dart';

String getWeatherIcon(String condition) {
  switch (condition.toLowerCase()) {
    case 'clear':
      return 'Assets/sun(1).png';
    case 'sunny':
      return 'Assets/sun(1).png';
    case 'partly cloudy':
      return 'Assets/partly-cloudy.png';
    case 'cloudy':
      return 'Assets/cloudy(1).png';
    case 'overcast':
      return 'Assets/overcast.png';
    case 'mist':
      return 'Assets/mist.png';
    case 'patchy rain possible':
      return 'Assets/light-rain(1).png';
    case 'light rain':
      return 'Assets/light-rain.png';
    case 'moderate rain':
      return 'Assets/light-rain(2).png';
    case 'heavy rain':
      return 'Assets/rainy.png';
    case 'light snow':
      return 'Assets/snow.png';
    case 'moderate snow':
      return 'Assets/snowfall.png';
    case 'heavy snow':
      return 'Assets/snowflake.png';
    case 'patchy freezing drizzle possible':
      return 'Assets/snow(1).png';
    case 'freezing rain':
      return 'Assets/snow(1).png';
    case 'patchy light rain with thunder':
      return 'Assets/storm.png';
    case 'moderate or heavy rain with thunder':
      return 'Assets/storm(1).png';
    case 'patchy light snow with thunder':
      return 'Assets/storm(1).png';
    case 'moderate or heavy snow with thunder':
      return 'Assets/storm(1).png';
    default:
      return 'Assets/weather.png';
  }
}
