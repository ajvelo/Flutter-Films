import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/core/extensions/character_model_ext.dart';
import 'package:flutter_films/features/characters/data/datasources/character_local_datasource.dart';
import 'package:flutter_films/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';
import 'package:flutter_films/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_films/features/characters/domain/repository/character_repository.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';

import '../models/character_model.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDatasource remoteDataSource;
  final CharacterLocalDataSource localDataSource;

  CharacterRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Stream<Either<Failure, Character>> getCharacters(
      {required CharacterParams params}) async* {
    try {
      final characterModels =
          await localDataSource.getCharacters(params: params);
      final characters = characterModels
          .map((characterModel) => characterModel.toCharacter)
          .toList();
      for (final char in characters) {
        yield Right(char);
      }
    } on CacheException catch (_) {
      final List<CharacterModel> characterModels = [];
      try {
        await for (final characterModel
            in remoteDataSource.getCharacters(params: params)) {
          final character = characterModel.toCharacter;
          characterModels.add(characterModel);
          yield Right(character);
        }
        await localDataSource.saveCharacters(
            characterModels: characterModels, params: params);
      } on ServerException catch (e) {
        yield Left(ServerFailure(message: e.message));
      } catch (e) {
        yield Left(ServerFailure(message: e.toString()));
      }
    }
  }
}
