import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final IconData icon;
  final String element;
  final String value;

  const CardItem({
    super.key,
    required this.icon,
    required this.element,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
            icon,
            size: 32
        ),

        const SizedBox(
            height: 8
        ),

        Text(
            element
        ),

        const SizedBox(
            height: 8
        ),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

