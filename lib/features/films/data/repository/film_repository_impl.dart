import 'package:dartz/dartz.dart';
import '../../../../core/extensions/film_model_ext.dart';

import '../../../../core/exception.dart';
import '../../../../core/failure.dart';
import '../../domain/entities/film.dart';
import '../../domain/repository/film_repository.dart';
import '../../domain/usecases/films_usecase.dart';
import '../datasources/film_local_datasource.dart';
import '../datasources/film_remote_datasource.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmRemoteDataSource remoteDateSource;
  final FilmLocalDataSource localDataSource;

  FilmRepositoryImpl(
      {required this.localDataSource, required this.remoteDateSource});

  @override
  Future<Either<Failure, List<Film>>> getFilms(
      {required FilmsParams params}) async {
    try {
      final filmModels = await localDataSource.getFilms();
      final films = filmModels.map((film) => film.toFilm).toList();
      return Right(films);
    } on CacheException catch (_) {
      try {
        final filmModels = await remoteDateSource.getFilms(params: params);
        localDataSource.saveFilms(filmModels: filmModels);
        final films = filmModels.map((film) => film.toFilm).toList();
        return Right(films);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on CastException catch (e) {
        return Left(CastFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Film>> toggleFilmAsFavorite(
      {required String uid, required FilmsParams params}) async {
    try {
      final filmModel =
          await localDataSource.toggleFilmAsFavorite(params: params, uid: uid);
      final film = filmModel.toFilm;
      return Right(film);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
