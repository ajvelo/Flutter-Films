import '../../../../core/exception.dart';
import '../../domain/usecases/films_usecase.dart';
import '../models/film_model.dart';
import 'film_hive_helper.dart';

abstract class FilmLocalDataSource {
  Future<List<FilmModel>> getFilms({required FilmsParams params});
  saveFilms({required List<FilmModel> filmModels, required FilmsParams params});
  Future<FilmModel> toggleFilmAsFavorite(
      {required FilmsParams params, required String uid});
}

class FilmLocalDataSourceImpl implements FilmLocalDataSource {
  final FilmHiveHelper filmHiveHelper;

  FilmLocalDataSourceImpl({required this.filmHiveHelper});
  @override
  Future<List<FilmModel>> getFilms({required FilmsParams params}) async {
    final films = await filmHiveHelper.getFilms(params: params);
    if (films.isNotEmpty) {
      return films;
    } else {
      throw CacheException(message: 'No films found');
    }
  }

  @override
  saveFilms(
      {required List<FilmModel> filmModels, required FilmsParams params}) {
    return filmHiveHelper.saveFilms(filmModels: filmModels, params: params);
  }

  @override
  Future<FilmModel> toggleFilmAsFavorite(
      {required String uid, required FilmsParams params}) async {
    final film =
        await filmHiveHelper.toggleFilmAsFavorite(uid: uid, params: params);
    return film;
  }
}
