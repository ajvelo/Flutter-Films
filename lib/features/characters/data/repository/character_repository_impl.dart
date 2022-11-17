import 'package:flutter_films/features/characters/data/datasources/character_local_datasource.dart';
import 'package:flutter_films/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';
import 'package:flutter_films/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_films/features/characters/domain/repository/character_repository.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDatasource remoteDatasource;
  final CharacterLocalDataSource localDataSource;

  CharacterRepositoryImpl(
      {required this.remoteDatasource, required this.localDataSource});
  @override
  Future<Either<Failure, List<Character>>> getCharacters(
      {required CharacterParams params}) async {
    try {
      // final characterModels = await localDataSource.getCharacters(params: params)

    } catch (e) {}
    return Left(ServerFailure(message: 'To be implemented'));
  }
}
