import 'package:flutter_films/features/characters/domain/entities/character.dart';
import 'package:flutter_films/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_films/features/characters/domain/repository/character_repository.dart';

class CharacterParams {
  final String path;
  CharacterParams({
    required this.path,
  });
}

class CharacterUsecase implements CharacterRepository {
  final CharacterRepository repository;

  CharacterUsecase({required this.repository});

  @override
  Either<Failure, List<Character>> getCharacters(
      {required CharacterParams params}) {
    return repository.getCharacters(params: params);
  }
}
