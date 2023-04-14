import 'package:hive_flutter/hive_flutter.dart';

// No-SQL Database to store the instance
class WeatherDatabase {
  List<String> city = []; // List of cities
  String cityName = ''; // Name of City

  // reference to box
  final _mybox = Hive.box('mybox');

  // Default data

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
