// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoListItemModelAdapter extends TypeAdapter<ToDoListItemModel> {
  @override
  final int typeId = 1;

  @override
  ToDoListItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoListItemModel(
      heading: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoListItemModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.heading)
      ..writeByte(2)
      ..write(obj.description)
    ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoListItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
