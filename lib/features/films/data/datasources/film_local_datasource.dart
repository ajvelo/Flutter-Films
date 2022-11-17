import '../../../../core/exception.dart';
import '../../domain/usecases/films_usecase.dart';
import '../models/film_model.dart';
import 'film_hive_helper.dart';

abstract class FilmLocalDataSource {
  Future<List<FilmModel>> getFilms();
  saveFilms({
    required List<FilmModel> filmModels,
  });
  Future<FilmModel> toggleFilmAsFavorite(
      {required FilmsParams params, required String uid});
}

class FilmLocalDataSourceImpl implements FilmLocalDataSource {
  final FilmHiveHelper filmHiveHelper;

  FilmLocalDataSourceImpl({required this.filmHiveHelper});
  @override
  Future<List<FilmModel>> getFilms() async {
    final films = await filmHiveHelper.getFilms();
    if (films.isNotEmpty) {
      return films;
    } else {
      throw CacheException(message: 'No films found');
    }
  }

  @override
  saveFilms({required List<FilmModel> filmModels}) {
    filmHiveHelper.saveFilms(filmModels: filmModels);
  }

  @override
  Future<FilmModel> toggleFilmAsFavorite(
      {required String uid, required FilmsParams params}) async {
    final film =
        await filmHiveHelper.toggleFilmAsFavorite(uid: uid, params: params);
    return film;
  }
}
