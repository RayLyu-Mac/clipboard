// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_base.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClipBoardsAdapter extends TypeAdapter<ClipBoards> {
  @override
  final int typeId = 0;

  @override
  ClipBoards read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClipBoards(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClipBoards obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.keys)
      ..writeByte(1)
      ..write(obj.values)
      ..writeByte(2)
      ..write(obj.times)
      ..writeByte(3)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClipBoardsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
