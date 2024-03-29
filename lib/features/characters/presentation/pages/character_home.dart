import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_films/core/routes/app_router.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';
import 'package:flutter_films/features/characters/presentation/providers/character_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CharacterHomePage extends ConsumerStatefulWidget {
  final List<String> characterUrls;
  final String uid;
  final String episodeNo;
  const CharacterHomePage(this.episodeNo,
      {super.key, required this.characterUrls, required this.uid});

  @override
  createState() => _CharacterHomePageState();
}

class _CharacterHomePageState extends ConsumerState<CharacterHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(characterProvider.notifier).getCharacters(
          params: CharacterParams(path: widget.characterUrls, uid: widget.uid));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearing in episode ${widget.episodeNo}'),
      ),
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
                    AutoRouter.of(context).push(CharacterDetailRoute(
                        character: character, id: character.uid));
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  title: Text(character.properties.name),
                  subtitle:
                      Text("Birth Year: ${character.properties.birthYear}"),
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
