import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/core/extensions/character_model_ext.dart';
import 'package:flutter_films/features/characters/data/datasources/character_local_datasource.dart';
import 'package:flutter_films/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';
import 'package:flutter_films/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_films/features/characters/domain/repository/character_repository.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDatasource remoteDataSource;
  final CharacterLocalDataSource localDataSource;

  CharacterRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<Either<Failure, List<Character>>> getCharacters(
      {required CharacterParams params}) async {
    try {
      final characterModels =
          await localDataSource.getCharacters(params: params);
      final characters = characterModels
          .map((characterModel) => characterModel.toCharacter)
          .toList();
      return Right(characters);
    } on CacheException catch (_) {
      final characterModels =
          await remoteDataSource.getCharacters(params: params);
      localDataSource.saveCharacters(
          characterModels: characterModels, params: params);
      final characters = characterModels
          .map((characterModel) => characterModel.toCharacter)
          .toList();
      return Right(characters);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
