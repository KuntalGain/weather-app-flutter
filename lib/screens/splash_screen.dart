// Screen will show everytime Launches the app

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0; // keep track of progress

  @override
  void initState() {
    super.initState();
    startTimer(); // method to show loading with percentage
  }

  // After Loading it will redirect to HomePage Screen
  startTimer() {
    Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        if (_progressValue == 1.0) {
          timer.cancel();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          _progressValue += 0.1;
          if (_progressValue > 1.0) {
            _progressValue = 1.0;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 300),

            // App Logo
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
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: Image.asset(
                  'Assets/logo.jpg',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                )),
            SizedBox(height: 20),

            // App Title
            Text(
              "Weatherify",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 100),

            // Circular Progress bar with Animated Percentage
            Column(
              children: [
                CircularProgressIndicator(
                  value: _progressValue,
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                SizedBox(height: 20.0),
                Text(
                  '${(_progressValue * 100).toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
