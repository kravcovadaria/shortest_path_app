// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortest_path.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShortestPathAdapter extends TypeAdapter<ShortestPath> {
  @override
  final int typeId = 0;

  @override
  ShortestPath read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShortestPath(
      id: fields[0] as String,
      start: fields[1] as PathPoint,
      end: fields[2] as PathPoint,
      field: (fields[3] as List)
          .map((dynamic e) => (e as List).cast<bool>())
          .toList(),
      steps: (fields[4] as List).cast<PathPoint>(),
    );
  }

  @override
  void write(BinaryWriter writer, ShortestPath obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.end)
      ..writeByte(3)
      ..write(obj.field)
      ..writeByte(4)
      ..write(obj.steps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortestPathAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
