import 'package:flutter/material.dart';
import 'package:weather_project/components/weather_body.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WeatherLico",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        foregroundColor: const Color.fromRGBO(226, 237, 255, 1),
        elevation: 100,
        scrolledUnderElevation: 5.0,
        toolbarHeight : 50,
        shadowColor: Colors.blue,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("you clicked the reload button");
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              print("you clicked the cancel button");
            },
            icon: const Icon(Icons.cancel),
          ),
          IconButton(
            onPressed: () {
              print("you clicked the change location button");
            },
            icon: const Icon(Icons.location_city),
            tooltip: "Change the location for the map information",
          ),
          IconButton(
            onPressed: () {
              print("Click this button to change the theme of the anplication");
            },
            icon: const Icon(Icons.apps_outlined),
            tooltip: "Change the location for the map information",
          ),
        ],
      ),
      body: const WeatherBody(),
    );
  }
}
