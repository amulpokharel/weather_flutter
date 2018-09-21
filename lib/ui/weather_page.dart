import 'package:flutter/material.dart';
import 'weather_card.dart';

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
            WeatherCard(),
          ],
        ),
      ),
    );
  }
}
