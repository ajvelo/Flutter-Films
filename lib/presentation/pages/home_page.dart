import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/films_usecase.dart';
import '../providers/providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filmsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Films')),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            if (state is GetFilmsSuccess) {
              return ListView.builder(
                itemCount: state.films.length,
                itemBuilder: (context, index) {
                  final film = state.films[index];
                  return ListTile(
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
