import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_project/components/additional_info_card.dart';
import 'package:weather_project/components/hourly_weather_view.dart';
import 'package:weather_project/secrets.dart';
import 'package:intl/intl.dart';

class WeatherBody extends StatefulWidget {
  const WeatherBody({super.key});

  @override
  State<WeatherBody> createState() => _WeatherBodyState();
}

class _WeatherBodyState extends State<WeatherBody> {

  Future<Map<String, dynamic>> getWeatherInformation() async {
    try {
      final String url =  'https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=$apiKey';
      final response =  await http.get(Uri.parse(url));

      if (response.statusCode  != 200) {
        throw "An unexpected error occurred";
      }

      final data = jsonDecode(response.body);

      return data;
    } catch (error) {
      throw "Error";
    }
  }
  // triggers a re-render when any of the state changes and this causes the init method to be reruned.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
        },
        icon: const Icon(
          Icons.add,
          size: 30,
        ),
        tooltip: "Testing the add functionality",
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.blue),
          foregroundColor: MaterialStatePropertyAll(Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getWeatherInformation(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child:  Text(
                  'This poor guy doesn\'t have data',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                ),
              ),
            );
          }

          final data = snapshot.data!;
          final mainTemperature = data['list'][0]['main']['temp'];
          final mainPressure = data['list'][0]['main']['pressure'];
          final mainHumidity = data['list'][0]['main']['humidity'];
          final mainSkyState = data['list'][0]['weather'][0]['main'];
          final mainWindSpeed = data['list'][0]['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Text(
                          "$mainTemperature F",
                          style: const TextStyle(
                            fontSize: 40,
                            color: Color.fromRGBO(226, 237, 255, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        Icon(
                            mainSkyState == "Clouds" || mainSkyState == "Rain"  ? Icons.cloud : Icons.sunny,
                          size: 60
                        ),

                        Text(
                            "$mainSkyState",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),

                // Weather Forecast part
                const SizedBox(
                  height: 8,
                ),

                const Text(
                  "Weather Forecast",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index ) {
                      final dateTime = DateTime.parse(data['list'][index]['dt_txt']);

                      return HourlyWeatherView(
                        time: DateFormat.Hm().format(dateTime),
                        clouds:  data['list'][index]['weather'][0]['main'],
                        temperature: data['list'][index]['main']['temp'].toString(),
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const Text(
                    "Additional Information",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoCard(
                      iconData: Icons.heat_pump,
                      value: mainHumidity.toString(),
                      description: 'Humidity',
                    ),
                    AdditionalInfoCard(
                      iconData: Icons.speed,
                      value: mainWindSpeed.toString(),
                      description: 'Wind Speed',
                    ),
                    AdditionalInfoCard(
                      iconData: Icons.security_update_good,
                      value: mainPressure.toString(),
                      description: 'Pressure',
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
