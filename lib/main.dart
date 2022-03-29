import 'package:flutter/material.dart';
import 'package:forecast_app/widgets/captured_satellites.dart';
import 'package:forecast_app/widgets/cloudiness.dart';
import 'package:forecast_app/widgets/gusts.dart';
import 'package:forecast_app/widgets/kp_index.dart';
import 'package:forecast_app/widgets/non_flight_zones.dart';
import 'package:forecast_app/widgets/precipitation.dart';
import 'package:forecast_app/widgets/recommendation.dart';
import 'package:forecast_app/widgets/sun.dart';
import 'package:forecast_app/widgets/temperature.dart';
import 'package:forecast_app/widgets/visible_satellites.dart';
import 'package:forecast_app/widgets/weather.dart';
import 'package:forecast_app/widgets/wind_speed.dart';
import 'package:forecast_app/widgets/wind_direction.dart';
import 'package:forecast_app/widgets/visibility.dart' as visibility_widget;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Recommendation(),
            const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: GridView.count(
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                childAspectRatio: 1.65,
                children: const <Widget>[
                  Weather(),
                  Sun(),
                  Temperature(),
                  WindSpeed(),
                  Gusts(),
                  WindDirection(),
                  Precipitation(),
                  Cloudiness(),
                  visibility_widget.Visibility(),
                  VisibleSatellites(),
                  KpIndex(),
                  CapturedSatellites(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const NonFlightZones(),
          ],
        ),
      ),
    );
  }
}
