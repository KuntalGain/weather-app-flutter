import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherService {
  Future<Weather> getWeatherdata(String place) async {
    final queryParameters = {
      'key': 'e1de2bb03f254e69b6370820230203',
      'q': place,
    };

    final uri =
        Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed To Fetch Data");
    }
  }

  Future<List<Forcast>> fetchForcast(String place) async {
    String api_key = 'e1de2bb03f254e69b6370820230203';

    String url =
        'http://api.weatherapi.com/v1/forecast.json?key=$api_key&q=$place&days=1&aqi=no&alerts=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // print(response.body);
      // extract json data
      List<Forcast> forecast = [];

      List<dynamic> forecastJson = json['forecast']['forecastday'][0]['hour'];
      forecastJson.forEach((dayJson) {
        String time = dayJson['time'];
        double temperature = dayJson['temp_c'];

        forecast.add(Forcast(time: time, temp: temperature));
      });

      return forecast;
    } else {
      throw Exception('Failed to Fetch data');
    }
  }
}
