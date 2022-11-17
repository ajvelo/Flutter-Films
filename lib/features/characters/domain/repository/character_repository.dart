import 'package:dartz/dartz.dart';
import 'package:flutter_films/core/failure.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';

abstract class CharacterRepository {
  Either<Failure, List<Character>> getCharacters(
      {required CharacterParams params});
}
