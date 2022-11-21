import 'package:flutter/material.dart';

import '../../domain/entities/character.dart';
import '../widgets/character_properties.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;
  const CharacterDetailPage({super.key, required this.character});
  @override
  Widget build(BuildContext context) {
    final characterProperties = character.properties;
    return Scaffold(
      appBar: AppBar(
        title: Text(character.properties.name),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'One of the characters appearing in the movie.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            CharacterProperties(
                propertyType: "Height",
                propertyValue: characterProperties.height),
            CharacterProperties(
                propertyType: "Mass", propertyValue: characterProperties.mass),
            CharacterProperties(
                propertyType: "Hair Color",
                propertyValue: characterProperties.hairColor),
            CharacterProperties(
                propertyType: "Skin Color",
                propertyValue: characterProperties.skinColor),
            CharacterProperties(
                propertyType: "Eye Color",
                propertyValue: characterProperties.eyeColor),
            CharacterProperties(
                propertyType: "Birth Year",
                propertyValue: characterProperties.birthYear),
            CharacterProperties(
                propertyType: "Gender",
                propertyValue: characterProperties.gender),
          ],
        ),
      )),
    );
  }
}
