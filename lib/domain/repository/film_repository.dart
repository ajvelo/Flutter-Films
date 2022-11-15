import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entities/film.dart';
import '../usecases/films_usecase.dart';

abstract class FilmRepository {
  Future<Either<Failure, List<Film>>> getFilms({required FilmsParams params});
  Future<Either<Failure, Film>> toggleFilmAsFavorite(
      {required String uid, required FilmsParams params});
}
