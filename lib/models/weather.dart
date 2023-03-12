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

class Forcast {
  String date;
  double temp;
  String condition;
  double? weatherCondition;

  Forcast(
      {this.date = '',
      this.temp = 0.0,
      this.condition = '',
      this.weatherCondition = 0.0});

  factory Forcast.fromJson(Map<String, dynamic> json) {
    return Forcast(
      temp: json["day"]["avgtemp_c"],
      date: json["date"],
      condition: json["day"]["condition"]["text"],
      weatherCondition: json["day"]["daily_chance_of_rain"],
    );
  }
}
