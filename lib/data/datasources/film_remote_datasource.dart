import 'package:dio/dio.dart';

import '../../core/exception.dart';
import '../../domain/usecases/films_usecase.dart';
import '../models/film_model.dart';

abstract class FilmRemoteDataSource {
  Future<List<FilmModel>> getFilms({required FilmsParams params});
}

class FilmsRemoteDataSourceImpl implements FilmRemoteDataSource {
  final Dio dio;
  final baseUrl = 'https://www.swapi.tech/api';

  FilmsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<FilmModel>> getFilms({required FilmsParams params}) async {
    try {
      final response = await dio.get(baseUrl + params.path);
      switch (response.statusCode) {
        case 200:
          final result = (response.data['result']);
          final films = (result as List)
              .map((filmModel) => FilmModel.fromJson(filmModel))
              .toList();
          return films;
        case 400:
          throw ServerException(message: 'Bad Request');
        default:
          throw ServerException(message: 'Error');
      }
    } on TypeError catch (e) {
      throw CastException(message: 'Cast Error');
    } on UnsupportedError catch (e) {
      throw ServerException(message: 'Server Error');
    } catch (e) {
      rethrow;
    }
  }
}
