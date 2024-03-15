import 'package:flutter/material.dart';

class AdditionalInfoCard extends StatelessWidget {
  const AdditionalInfoCard({super.key, required this.description, required this.iconData, required this.value});
  final String description;
  final IconData iconData;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(iconData),
            const SizedBox(
              height: 5,
            ),
            Text(
              description
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              value
            ),
          ],
        ),
      ),
    );
  }
}
