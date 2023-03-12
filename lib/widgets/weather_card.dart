import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_icons.dart';

Widget weatherCard(
    {required double temp, required String date, required String condition}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      height: 100,
      width: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Colors.blue,
            Colors.grey,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            getWeatherIcon(condition.toString()),
            height: 30,
            width: 30,
          ),
          Text('$date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              )),
          Text('${temp}°C',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ],
      ),
    ),
  );
}
