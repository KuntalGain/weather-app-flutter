import 'package:flutter/material.dart';

class RetryPageState extends StatelessWidget {
  final Function() onRetryPressed;

  const RetryPageState({super.key, required this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 100,
          ),
          Image.asset(
            'Assets/5356680.jpg',
            // height: 100,
            width: 400,
          ),
          Text(
            "No Internet Connection Available",
            style: TextStyle(fontSize: 25),
          ),
          MaterialButton(
            onPressed: onRetryPressed,
            child: Text("Retry"),
            color: Colors.blue,
            highlightColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
