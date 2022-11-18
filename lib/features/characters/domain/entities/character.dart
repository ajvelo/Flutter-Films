import 'package:equatable/equatable.dart';
import 'package:flutter_films/features/characters/domain/entities/properties.dart';

class Character extends Equatable {
  const Character({
    required this.properties,
    required this.uid,
  });

  final Properties properties;

  final String uid;

  @override
  List<Object?> get props => [properties, uid];
}
