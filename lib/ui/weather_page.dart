import 'package:flutter/material.dart';
import 'dart:async';
import 'weather_card.dart';
import 'package:geocoder/geocoder.dart';

import 'package:location/location.dart';
import 'package:flutter/services.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WeatherPageState createState() => new _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.timelapse),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            WeatherCard(lat: 39.055476, lng: -77.120931),
          ],
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    var currentLocation = <String, double>{};
    var location = new Location();
    Address address;

    try {
      currentLocation = await location.getLocation();
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          new Coordinates(
              currentLocation["latitude"], currentLocation["longitude"]));
      address = addresses.first;
    } on PlatformException {
      return;
    }
  }
}
