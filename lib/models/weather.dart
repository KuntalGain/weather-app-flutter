// Weather Class represents the current Weather Conditions
class Weather {
  // parameters
  double temp;
  double wind;
  int humidity;
  double pressure;
  double feelsLike;
  String condition;

  // constructor
  Weather({
    this.temp = 0,
    this.wind = 0,
    this.pressure = 0,
    this.humidity = 0,
    this.feelsLike = 0,
    this.condition = '',
  });

  //Method to Create Weather Object from API json Data
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['current']['temp_c'],
      wind: json['current']['wind_kph'],
      pressure: json['current']['pressure_mb'],
      humidity: json['current']['humidity'],
      feelsLike: json['current']['feelslike_c'],
      condition: json['current']['condition']['text'],
    );
  }
}

// Forcast Class represents the 24hr Weather Forcast
class Forcast {
  String time;
  double temp;
  String condition;
  double? weatherCondition;

  Forcast(
      {this.time = '',
      this.temp = 0.0,
      this.condition = '',
      this.weatherCondition = 0.0});

  // Method to create Forcast Object from API json data
  factory Forcast.fromJson(Map<String, dynamic> json) {
    return Forcast(
      temp: json["hour"]["temp_c"],
      time: json["hour"]["time"],
      condition: json["hour"]["condition"]["text"],
      weatherCondition: json["hour"]["daily_chance_of_rain"],
    );
  }
}
