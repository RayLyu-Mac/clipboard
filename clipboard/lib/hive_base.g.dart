// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_base.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClipboardAdapter extends TypeAdapter<Clipboard> {
  @override
  final int typeId = 0;

  @override
  Clipboard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Clipboard(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Clipboard obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.keys)
      ..writeByte(1)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClipboardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
