// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_point.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PathPointAdapter extends TypeAdapter<PathPoint> {
  @override
  final int typeId = 1;

  @override
  PathPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PathPoint(
      fields[0] as int,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PathPoint obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.x)
      ..writeByte(1)
      ..write(obj.y);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PathPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
