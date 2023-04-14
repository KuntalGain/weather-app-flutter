import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:location/location.dart';
import 'package:weather_app/database/database.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/notification_alert.dart';

import 'package:weather_app/services/timer.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/services/weather_icons.dart';
import 'package:weather_app/widgets/saved_cities.dart';
import 'package:weather_app/widgets/value_widget.dart';
import 'package:weather_app/services/current_location.dart';
import 'package:weather_app/widgets/weather_card.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Database
  final _mybox = Hive.box('mybox');
  WeatherDatabase db = WeatherDatabase();

  // Make Instance of weather APIs
  WeatherService weatherService = WeatherService();
  Weather weather = Weather();
  Forcast forcast = Forcast();

  // Notification Services
  NotificationServices notificationServices = NotificationServices();

  // parameters
  double temp = 0.0;
  String? cityName;
  double wind = 0.0;
  int humidity = 0;
  double pressure = 0;
  double feelsLike = 0.0;
  String condition = '';
  double weatherCondition = 0;

  double today = 0.0;

  // map
  double lat = 0.0;
  double lon = 0.0;

  // controller
  final _textController = TextEditingController();

  @override
  void initState() {
    db.city.add('London');

    // if app launched for the first Time then create data
    if (_mybox.get("WEATHER_KEY") == null) {
      db.createDefaultData();
    } else {
      // if data exists then load data
      db.loadData();
    }

    super.initState();
    getWeather(); // get Current Weather
    getForcast(); // get 24hr Forcast

    // Initialize the notification
    notificationServices.initializeNotification();

    // Alert User's there Gonna be Rainfall
    notificationServices.sendNotification("Bring Umbrella ☂️",
        "In ${db.cityName} gonna be RainFall", forcast.weatherCondition);
  }

  // Method to fetch Current Weather
  void getWeather() async {
    weather = await weatherService.getWeatherdata(db.cityName.toString());

    setState(() {
      temp = weather.temp;
      wind = weather.wind;
      humidity = weather.humidity;
      pressure = weather.pressure;
      feelsLike = weather.feelsLike;
      condition = weather.condition;
    });

    print(weather.temp);
  }

  // Method for Fetch 24hr Weather Forcast
  Future<void> getForcast() async {
    List<Forcast> forecast =
        await weatherService.fetchForcast(db.cityName.toString());
    DateTime now = DateTime.now();
    print(now);
    DateTime targetDate = now.add(Duration(hours: 24));
    String targetDateTime = DateFormat('yyyy-MM-dd HH:mm').format(targetDate);

    Forcast? targetForcast;

    for (var f in forecast) {
      if (f.time == targetDateTime) {
        targetForcast = f;
        break;
      }
    }

    if (targetForcast == null) {
      print('No Forcast Record');
    } else {
      print('${targetForcast.temp}°C');
    }
  }

  // Method that asks User's for Location Permission and fetch current location weather
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location Service is Disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Loction Permisson are Denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permission are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(15),

        // resposivness of our App
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Time-Location
            Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // City Name & date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        db.cityName.toString(),
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currentTime(),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // city History
                      IconButton(
                          onPressed: () {
                            print(db.city);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Saved Cities'),
                                    content: Container(
                                      color: Colors.white,
                                      height: (db.city.length == -1)
                                          ? 50
                                          : db.city.length * 100,
                                      width: (db.city.length == -1)
                                          ? 50
                                          : db.city.length * 100,
                                      child: (db.city.length == -1)
                                          ? Text('No Saved Cities')
                                          : Expanded(
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: db.city.length,
                                                itemBuilder: (context, index) =>
                                                    SavedCityList(
                                                  cityName: db.city[index],
                                                  onTap: () {
                                                    setState(() {
                                                      db.city.removeAt(index);
                                                      Navigator.pop(context);
                                                    });
                                                    db.updatedata();
                                                  },
                                                  onPressEvent: () {
                                                    setState(() {
                                                      db.cityName =
                                                          db.city[index];
                                                      getWeather();
                                                      getForcast();
                                                      Navigator.pop(context);
                                                    });
                                                    db.updatedata();
                                                    notificationServices
                                                        .sendNotification(
                                                            "Bring Umbrella ☂️",
                                                            "In ${db.cityName} gonna be RainFall",
                                                            forcast
                                                                .weatherCondition);
                                                  },
                                                ),
                                              ),
                                            ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.location_city,
                            size: 35,
                            color: Colors.blue,
                          )),
                      // Add City
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text('Add City'),
                                      content: Container(
                                        height: 150,
                                        width: double.infinity,
                                        // color: Colors.black,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextField(
                                              controller: _textController,
                                              decoration: InputDecoration(
                                                  hintText: 'ex-London'),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  db.cityName =
                                                      _textController.text;
                                                  _textController.clear();

                                                  db.city.add(
                                                      db.cityName.toString());
                                                  print(db.city);

                                                  getWeather();
                                                  getForcast();
                                                  Navigator.pop(context);
                                                });

                                                db.updatedata();
                                                notificationServices
                                                    .sendNotification(
                                                        "Bring Umbrella ☂️",
                                                        "In ${db.cityName} gonna be RainFall",
                                                        forcast
                                                            .weatherCondition);
                                                // widget.addCity();
                                              },
                                              color: Colors.blue,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.deepPurple,
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                });
                          },
                          icon: Icon(
                            Icons.add,
                            size: 35,
                            color: Colors.blue,
                          )),
                      // Current Location
                      IconButton(
                        icon: Icon(
                          Icons.location_on,
                          size: 35,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          _getCurrentLocation().then((value) async {
                            lat = value.latitude;
                            lon = value.longitude;
                            String? city = await getCityName(lat, lon);
                            setState(() {
                              db.cityName = city.toString();
                              db.city.add(city.toString());
                              getWeather();
                            });
                            db.updatedata();
                            notificationServices.sendNotification(
                                "Bring Umbrella ☂️",
                                "In ${db.cityName} gonna be RainFall",
                                forcast.weatherCondition);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Weather Card

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  // weather icon
                  Center(
                      child: Image.asset(
                    getWeatherIcon(condition),
                    height: 100,
                    width: 100,
                  )),
                  SizedBox(
                    height: 20,
                  ),

                  // current Temperature
                  (temp != 0.0)
                      ? Center(
                          child: Text(
                            " ${temp.toString()} °C",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : CircularProgressIndicator(),
                  SizedBox(
                    height: 5,
                  ),

                  // current Conditions
                  (temp != 0.0)
                      ? Text(
                          condition,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : CircularProgressIndicator(),
                ],
              ),
            ),

            // Additional Info

            Container(
              margin: EdgeInsets.all(20),
              child: Divider(
                thickness: 2.0,
                color: Colors.black,
              ),
            ),

            Text(
              "Additional Informtion",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            (temp != 0.0)
                ? additionalInformation(
                    "${wind}",
                    "${humidity}",
                    "${pressure}",
                    "${feelsLike}",
                  )
                : CircularProgressIndicator(),

            // 24hr Forcast
            Container(
              margin: EdgeInsets.all(20),
              child: Divider(
                thickness: 2.0,
                color: Colors.black,
              ),
            ),
            Text(
              '24 Hour Forecast',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder<List<Forcast>>(
              future: weatherService.fetchForcast(db.cityName.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final forcastList = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 24,
                        itemBuilder: (context, index) {
                          final forcast = forcastList![index];

                          String datetime = forcast.time;
                          String dateString =
                              datetime.substring(11, datetime.length);

                          return weatherCard(
                            temp: forcast.temp,
                            date: dateString,
                            condition: condition,
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ), // Temperature
    );
  }
}
