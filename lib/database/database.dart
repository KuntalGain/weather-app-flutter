import 'package:hive_flutter/hive_flutter.dart';

class WeatherDatabase {
  List<String> city = [];
  String cityName = '';

  // reference to box
  final _mybox = Hive.box('mybox');

  // Default Method of Running

  void createDefaultData() {
    city = ["London", "New York"];
    cityName = 'London';
  }

  // Load Data

  void loadData() {
    city = _mybox.get("WEATHER_KEY");
    if (city != null && city.isNotEmpty) {
      cityName = city.last;
    }
  }

  // Update Data

  void updatedata() {
    _mybox.put("WEATHER_KEY", city);
  }
}
