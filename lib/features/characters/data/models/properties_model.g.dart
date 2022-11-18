// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PropertiesModelAdapter extends TypeAdapter<PropertiesModel> {
  @override
  final int typeId = 2;

  @override
  PropertiesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PropertiesModel(
      height: fields[0] as String,
      mass: fields[1] as String,
      hairColor: fields[2] as String,
      skinColor: fields[3] as String,
      eyeColor: fields[4] as String,
      birthYear: fields[5] as String,
      gender: fields[6] as String,
      created: fields[7] as DateTime,
      edited: fields[8] as DateTime,
      name: fields[9] as String,
      homeworld: fields[10] as String,
      url: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PropertiesModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.height)
      ..writeByte(1)
      ..write(obj.mass)
      ..writeByte(2)
      ..write(obj.hairColor)
      ..writeByte(3)
      ..write(obj.skinColor)
      ..writeByte(4)
      ..write(obj.eyeColor)
      ..writeByte(5)
      ..write(obj.birthYear)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.created)
      ..writeByte(8)
      ..write(obj.edited)
      ..writeByte(9)
      ..write(obj.name)
      ..writeByte(10)
      ..write(obj.homeworld)
      ..writeByte(11)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertiesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
