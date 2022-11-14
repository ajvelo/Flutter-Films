import 'package:dartz/dartz.dart';
import 'package:flutter_films/core/extensions/film_model_ext.dart';

import '../../core/exception.dart';
import '../../core/failure.dart';
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
      final filmModels = await localDataSource.getFilms(params: params);
      final films = filmModels.map((film) => film.toFilm).toList();
      return Right(films);
    } on CacheException catch (e) {
      final filmModels = await remoteDateSource.getFilms(params: params);
      localDataSource.saveFilms(filmModels: filmModels, params: params);
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

  @override
  Future<Either<Failure, Film>> toggleFilmAsFavorite(
      {required int episodeId, required FilmsParams params}) async {
    try {
      final filmModel = await localDataSource.toggleFilmAsFavorite(
          params: params, episodeId: episodeId);
      final film = filmModel.toFilm;
      return Right(film);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
