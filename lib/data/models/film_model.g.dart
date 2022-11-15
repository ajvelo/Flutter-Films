// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilmModelAdapter extends TypeAdapter<FilmModel> {
  @override
  final int typeId = 0;

  @override
  FilmModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilmModel(
      title: fields[0] as String,
      episodeId: fields[1] as int,
      openingCrawl: fields[2] as String,
      director: fields[3] as String,
      producer: fields[4] as String,
      releaseDate: fields[5] as DateTime,
      characters: (fields[6] as List).cast<String>(),
      planets: (fields[7] as List).cast<String>(),
      starships: (fields[8] as List).cast<String>(),
      vehicles: (fields[9] as List).cast<String>(),
      species: (fields[10] as List).cast<String>(),
      created: fields[11] as DateTime,
      edited: fields[12] as DateTime,
      url: fields[13] as String,
      isFavorite: fields[14] as bool,
      uid: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FilmModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.episodeId)
      ..writeByte(2)
      ..write(obj.openingCrawl)
      ..writeByte(3)
      ..write(obj.director)
      ..writeByte(4)
      ..write(obj.producer)
      ..writeByte(5)
      ..write(obj.releaseDate)
      ..writeByte(6)
      ..write(obj.characters)
      ..writeByte(7)
      ..write(obj.planets)
      ..writeByte(8)
      ..write(obj.starships)
      ..writeByte(9)
      ..write(obj.vehicles)
      ..writeByte(10)
      ..write(obj.species)
      ..writeByte(11)
      ..write(obj.created)
      ..writeByte(12)
      ..write(obj.edited)
      ..writeByte(13)
      ..write(obj.url)
      ..writeByte(14)
      ..write(obj.isFavorite)
      ..writeByte(15)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilmModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
