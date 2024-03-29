import 'package:flutter/material.dart';

class CharacterProperties extends StatelessWidget {
  const CharacterProperties({
    super.key,
    required this.propertyValue,
    required this.propertyType,
  });

  final String propertyValue;
  final String propertyType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$propertyType:",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          propertyValue,
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }
}
