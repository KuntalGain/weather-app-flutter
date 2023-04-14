import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';

// Method for Showing Additional Information

Widget additionalInformation(
    String wind, String humidity, String pressure, String feels_like) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  attribute[0],
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Feels Like"),
                ),
                Text(
                  '${feels_like}°C',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  attribute[1],
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Humidity"),
                ),
                Text(
                  '${humidity}%',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  attribute[2],
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Pressure"),
                ),
                Text(
                  '${pressure}\n\t\t\tkph',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  attribute[3],
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("wind"),
                ),
                Text(
                  '${wind}\nkm/h',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
