import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';

class WeatherCard extends StatefulWidget {
  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String locStr = "No location";
  Address address;
  String weather = "0.0";
  String iconStr = "01d";
  Map<String, dynamic> weatherResponse;

  @override
  Widget build(BuildContext context) {
    getWeather();
    return new Container(
        child: new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.network(
                  "http://openweathermap.org/img/w/$iconStr.png",
                  height: 40.0,
                  width: 40.0,
                ),
                Column(children: <Widget>[
                  Text(
                    "$weather°F",
                  ),
                  Text(
                    "$locStr",
                  )
                ]),
              ],
            ),
          ],
        ),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center);
  }

  void getWeather() async {
    var currentLocation = <String, double>{};
    var location = new Location();

    try {
      currentLocation = await location.getLocation();
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          new Coordinates(
              currentLocation["latitude"], currentLocation["longitude"]));

      address = addresses.first;
    } on PlatformException {
      currentLocation = null;
    }

    final response = await http.get(
      "https://api.openweathermap.org/data/2.5/weather?lat=${currentLocation["latitude"]}&lon=${currentLocation["longitude"]}&appid=50aaa0b9c38198d17df8b2140f09879e",
    );

    if (response.statusCode == 200) {
      weatherResponse = json.decode(response.body);
      weather = ((weatherResponse["main"]["temp"] * (9 / 5) - 459.67)
          .toStringAsFixed(2));
      iconStr = weatherResponse["weather"][0]["icon"];
      locStr =
          address.subAdminArea.toString() + ", " + address.adminArea.toString();

      setState(() {});
    } else {
      throw Exception('Failed to get weather');
    }
  }
}
