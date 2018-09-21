import 'package:flutter/material.dart';
import 'ui/weather_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Weather',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new WeatherPage(title: 'Weather'),
    );
  }
}