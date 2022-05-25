// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostTableAdapter extends TypeAdapter<PostTable> {
  @override
  final int typeId = 0;

  @override
  PostTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostTable(
      tId: fields[0] as int,
      tTitle: fields[1] as String,
      tBody: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PostTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tId)
      ..writeByte(1)
      ..write(obj.tTitle)
      ..writeByte(2)
      ..write(obj.tBody);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
