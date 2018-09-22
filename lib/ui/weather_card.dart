import 'dart:convert';
import 'dart:core';
import 'package:geocoder/geocoder.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherCard extends StatefulWidget {
  WeatherCard({Key key, this.lng, this.lat}) : super(key: key);

  final double lng;
  final double lat;

  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String locStr = "Fetching Location..";
  String currentState = "";
  String weather = "Loading";
  String iconStr = "01d";
  Address address;
  Map<String, dynamic> weatherResponse;

  @override
  Widget build(BuildContext context) {
    getWeather();

    return new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$locStr",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(100, 51, 51, 51)),
            ),
            Text(
              "$currentState",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(100, 51, 51, 51)),
            ),
            Row(
              children: <Widget>[
                Image.network(
                  "http://openweathermap.org/img/w/$iconStr.png",
                  height: 64.0,
                  width: 64.0,
                  fit: BoxFit.fill,
                ),
                Column(children: <Widget>[
                  Text(
                    "$weather°F",
                    style: TextStyle(
                      fontSize: 64.0,
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center);
  }

  void getWeather() async {
    var temp = await Geocoder.local
        .findAddressesFromCoordinates(new Coordinates(widget.lat, widget.lng));

    address = temp.first;
    locStr = address.locality.toString() + ", " + address.adminArea.toString();

    final response = await http.get(
      "https://api.openweathermap.org/data/2.5/weather?lat=${widget.lat}&lon=${widget.lng}&appid=50aaa0b9c38198d17df8b2140f09879e",
    );

    if (response.statusCode == 200) {
      weatherResponse = json.decode(response.body);
      weather = ((weatherResponse["main"]["temp"] * (9 / 5) - 459.67)
          .toStringAsFixed(1));
      iconStr = weatherResponse["weather"][0]["icon"];

      currentState = weatherResponse["weather"][0]["description"];
      currentState = currentState[0].toUpperCase() + currentState.substring(1);

      setState(() {});
    } else {
      throw Exception('Failed to get weather');
    }
  }
}
