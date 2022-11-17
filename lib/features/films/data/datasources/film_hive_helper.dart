import '../../../../core/exception.dart';
import '../../domain/usecases/films_usecase.dart';
import 'film_local_datasource.dart';
import '../models/film_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FilmHiveHelper implements FilmLocalDataSource {
  Future<Box<FilmModel>> _getBox() async {
    Box<FilmModel> box;
    box = await Hive.openBox<FilmModel>('films');
    return box;
  }

  @override
  Future<List<FilmModel>> getFilms() async {
    final box = await _getBox();
    final films = box.values.toList();
    return films;
  }

  @override
  saveFilms({
    required List<FilmModel> filmModels,
  }) async {
    final box = await _getBox();
    await box.clear();
    filmModels.forEach((filmModel) async {
      box.put(filmModel.uid, filmModel);
    });
  }

  @override
  Future<FilmModel> toggleFilmAsFavorite(
      {required String uid, required FilmsParams params}) async {
    final box = await _getBox();
    final filmModel = box.get(uid);
    if (filmModel == null) {
      throw CacheException(message: 'No films found');
    } else {
      filmModel.isFavorite = !filmModel.isFavorite;
      box.put(filmModel.uid, filmModel);
      return filmModel;
    }
  }
}
