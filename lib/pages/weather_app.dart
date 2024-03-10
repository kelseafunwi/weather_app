import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_project/pages/hourly_forecast_items.dart';
import 'package:weather_project/pages/weather_info_components.dart';
import "package:http/http.dart" as http;
import 'package:weather_project/secrets.dart';
import 'package:intl/intl.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
    Future getCurrentWeather() async {
    try{
      String cityName = "London";
      final res = await http.get(Uri.parse("http://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$apiKey"));
      // decoding the request results since it comes in the form of a Json String .
      final data = jsonDecode(res.body);

      if (int.parse(data['cod']) != 200) {
        throw data['message'];
      }

      // returning the data to the future after we finished fetching the data
      return data;
    }catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Weather app",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
        ),
        centerTitle: true,
        actions:  [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh)
          )
        ],
      ),
      backgroundColor: Colors.black,
      body:  FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          final data = snapshot.data;

          final String sky = data['list'][0]['weather'][0]['main'];
          final double currentTemperature = data['list'][0]['main']['temp'];
          final int humidity = data['list'][0]['main']['humidity'];
          final int pressure = data['list'][0]['main']['pressure'];
          final double windSpeed = data['list'][0]['wind']['speed'];


          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              // adaptive makes it to use the loading which is used by that platform
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            // prints out the error to the screen if there is any.
            return Text(snapshot.error.toString());
          }
          //snapshot helps us manage all of the state in our application
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            //   main card
               SizedBox(
                 width: double.infinity,
                 child: Card(
                   elevation: 10,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(16),
                   ),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(16),
                     child: BackdropFilter(
                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                       child: Padding(
                         padding: const EdgeInsets.all(16.0),
                         child: Column(
                           children: [
                              Text(
                                  "${currentTemperature.toString()} °F",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                             const SizedBox(
                               height: 16,
                             ),
                              Icon(
                                 sky == "Clouds" || sky == "Rain" ?
                                 Icons.cloud: Icons.sunny
                               ,
                               size: 64,
                             ),
                             const SizedBox(
                               height: 16,
                             ),
                             Text(
                               sky,
                               style: const TextStyle(
                                 fontSize: 16
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               ),

              const SizedBox(height: 13),

              const Text(
                "Hourly Forecast",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, i) {
                    final dateTime = DateTime.parse(data['list'][i+1]['dt_txt']);
                    final sky = data['list'][i+1]['weather'][0]['main'];
                    final temperature = data['list'][i+1]['main']['temp'];
                    return  HourlyForecastItem(
                      time: DateFormat.j().format(dateTime),
                      icon: sky == 'Clouds' || sky == "Rain" ? Icons.cloud : Icons.sunny,
                      temperature: temperature.toString(),
                    );
                  }
                ),
              ),

              const SizedBox(height: 13),

              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardItem(
                    icon: Icons.water_drop,
                    element: 'Humidity',
                    value: humidity.toString(),
                  ),
                  CardItem(
                    icon: Icons.speed,
                    element: 'Wind Speed',
                    value: windSpeed.toString(),
                  ),
                  CardItem(
                    icon: Icons.beach_access,
                    element: 'Pressure',
                    value: pressure.toString(),
                  ),
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }
}
