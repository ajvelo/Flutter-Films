import '../../data/models/film_model.dart';
import '../../domain/entities/film.dart';

extension FilmModelExtension on FilmModel {
  Film get toFilm => Film(
      title: title,
      episodeId: episodeId,
      openingCrawl: openingCrawl,
      director: director,
      producer: producer,
      releaseDate:
          "${releaseDate.day}/${releaseDate.month.toString().padLeft(2, "0")}/${releaseDate.year}",
      characters: characters,
      planets: planets,
      starships: starships,
      vehicles: vehicles,
      species: species,
      created: created,
      edited: edited,
      url: url,
      isFavorite: isFavorite,
      uid: uid);
}
