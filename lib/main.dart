import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:weather_app/screens/retry_page.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/services/notification_alert.dart';
import 'package:connectivity/connectivity.dart';
import 'package:splash/splash.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  //init Hive
  await Hive.initFlutter();

  // open the box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isOffline = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkInternetConnectivity();

    Connectivity().onConnectivityChanged.listen((event) {
      _checkInternetConnectivity();
    });
  }

  void _checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    setState(() {
      _isOffline = connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      // home: UpdateApp(),
      home: _isOffline ? RetryPageState(onRetryPressed: () {}) : SplashScreen(),
    );
  }
}

class UpdateApp extends StatefulWidget {
  const UpdateApp({super.key});

  @override
  State<UpdateApp> createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notificationServices.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image.network(
                'https://cdn.icon-icons.com/icons2/3176/PNG/512/app_development_computer_mobile_settings_cogwheel_icon_193862.png'),
          ),
          Text(
            'App is Under Development',
            style: titleFont,
          ),
        ],
      ),
    );
  }
}
