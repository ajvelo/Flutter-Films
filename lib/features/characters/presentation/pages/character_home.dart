import 'package:flutter/material.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';
import 'package:flutter_films/features/characters/presentation/providers/character_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterHomePage extends ConsumerStatefulWidget {
  final List<String> characterUrls;
  const CharacterHomePage({super.key, required this.characterUrls});

  @override
  createState() => _CharacterHomePageState();
}

class _CharacterHomePageState extends ConsumerState<CharacterHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(characterProvider.notifier)
          .getCharacters(params: CharacterParams(path: widget.characterUrls));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Consumer(
        builder: (context, ref, child) {
          if (state is GetCharactersSuccess) {
            final characters = state.characters;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  onTap: () {
                    // Go to character
                  },
                  title: Text(character.properties.name),
                  subtitle: Text(character.properties.birthYear),
                );
              },
            );
          } else if (state is GetCharactersError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
