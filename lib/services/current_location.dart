import 'package:geocoding/geocoding.dart';

// method to get City Name with latitude and Longitude
Future<String?> getCityName(double lat, double lon) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
  String? cityName = placemarks[0].locality;

  return cityName;
}
