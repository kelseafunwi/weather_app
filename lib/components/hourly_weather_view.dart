import 'package:flutter/material.dart';


class HourlyWeatherView extends StatelessWidget {
  const HourlyWeatherView({super.key,  required this.time, required this.clouds, required this.temperature});

  final String time;
  final String clouds;
  final String temperature;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                color: Color.fromRGBO(226, 237, 255, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Icon(
              clouds == "Clouds" || clouds == "Rain"  ? Icons.cloud : Icons.sunny,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              temperature,
              style: const TextStyle(
                color: Color.fromRGBO(226, 237, 255, 1),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
