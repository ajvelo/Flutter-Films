import '../../../../core/exception.dart';
import '../../domain/usecases/films_usecase.dart';
import 'film_local_datasource.dart';
import '../models/film_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FilmHiveHelper implements FilmLocalDataSource {
  Future<Box<FilmModel>> _getBox({required FilmsParams params}) async {
    Box<FilmModel> box;
    if (params.path == '/films') {
      box = await Hive.openBox<FilmModel>('films');
    } else {
      box = await Hive.openBox<FilmModel>('other-films');
    }
    return box;
  }

  @override
  Future<List<FilmModel>> getFilms({required FilmsParams params}) async {
    final box = await _getBox(params: params);
    final films = box.values.toList();
    return films;
  }

  @override
  saveFilms(
      {required List<FilmModel> filmModels,
      required FilmsParams params}) async {
    final box = await _getBox(params: params);
    await box.clear();
    filmModels.forEach((filmModel) async {
      box.put(filmModel.uid, filmModel);
    });
  }

  @override
  Future<FilmModel> toggleFilmAsFavorite(
      {required String uid, required FilmsParams params}) async {
    final box = await _getBox(params: params);
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
