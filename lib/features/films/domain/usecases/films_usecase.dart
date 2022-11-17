import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entities/film.dart';
import '../repository/film_repository.dart';

class FilmsParams {
  final String path;
  FilmsParams({
    required this.path,
  });
}

class FilmsUsecase implements FilmRepository {
  final FilmRepository repository;

  FilmsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<Film>>> getFilms({required FilmsParams params}) {
    return repository.getFilms(params: params);
  }

  @override
  Future<Either<Failure, Film>> toggleFilmAsFavorite(
      {required String uid, required FilmsParams params}) {
    return repository.toggleFilmAsFavorite(uid: uid, params: params);
  }
}
