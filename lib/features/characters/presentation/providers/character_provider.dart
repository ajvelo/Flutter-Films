import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_films/features/characters/data/datasources/character_hive_helper.dart';
import 'package:flutter_films/features/characters/data/datasources/character_local_datasource.dart';
import 'package:flutter_films/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:flutter_films/features/characters/data/repository/character_repository_impl.dart';
import 'package:flutter_films/features/characters/domain/entities/character.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure.dart';

final characterProvider =
    NotifierProvider<CharacterNotifier, GetCharactersState>(() {
  final characterNotifier = CharacterNotifier(
    usecase: CharacterUsecase(
        repository: CharacterRepositoryImpl(
            localDataSource: CharacterLocalDataSourceImpl(
                characterHiveHelper: CharacterHiveHelper()),
            remoteDataSource: CharacterRemoteDatasourceImpl(dio: Dio()))),
  );
  return characterNotifier;
});

class CharacterNotifier extends Notifier<GetCharactersState> {
  final CharacterUsecase usecase;
  final List<Character> characters = [];

  CharacterNotifier({required this.usecase}) : super();

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CastFailure:
        return (failure as CastFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      default:
        return 'Unknown error';
    }
  }

  void getCharacters({required CharacterParams params}) async {
    state = GetCharactersLoading();
    await for (final result in usecase.getCharacters(params: params)) {
      result.fold((failure) {
        state = GetCharactersError(errorMessage: _getErrorMessage(failure));
      }, (character) {
        characters.add(character);
        characters.sort((a, b) {
          return a.properties.name.compareTo(b.properties.name);
        });
        state = GetCharactersSuccess(characters: characters);
      });
    }
  }

  @override
  GetCharactersState build() {
    return GetCharactersInitial();
  }
}

abstract class GetCharactersState extends Equatable {}

class GetCharactersInitial extends GetCharactersState {
  @override
  List<Object?> get props => [];
}

class GetCharactersLoading extends GetCharactersState {
  @override
  List<Object?> get props => [];
}

class GetCharactersSuccess extends GetCharactersState {
  final List<Character> characters;

  GetCharactersSuccess({required this.characters});

  @override
  List<Object?> get props => [characters];
}

class GetCharactersError extends GetCharactersState {
  final String errorMessage;

  GetCharactersError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
