import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterHomePage extends ConsumerWidget {
  final List<String> characters;
  const CharacterHomePage({required this.characters, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(characters);
    return Scaffold(
      appBar: AppBar(),
      body: Text(characters.first),
    );
  }
}
