import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_films/core/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/films_usecase.dart';
import '../providers/film_provider.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filmsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Star Wars')),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            if (state is GetFilmsSuccess) {
              return ListView.builder(
                itemCount: state.films.length,
                itemBuilder: (context, index) {
                  final film = state.films[index];
                  return ListTile(
                    onTap: () {
                      AutoRouter.of(context).push(CharacterHomeRoute(
                          episodeNo: "${film.episodeId}",
                          characterUrls: film.characters,
                          uid: film.uid));
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    title: Text(film.title),
                    leading: IconButton(
                      icon: film.isFavorite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      onPressed: () {
                        ref.read(filmsProvider.notifier).toggleFilmAsFavorite(
                            uid: film.uid, params: FilmsParams(path: '/films'));
                      },
                    ),
                    subtitle: Text(film.releaseDate),
                  );
                },
              );
            } else if (state is GetFilmsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetFilmsError) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: () {
          ref
              .read(filmsProvider.notifier)
              .getFilms(params: FilmsParams(path: "/films"));
        },
      ),
    );
  }
}
