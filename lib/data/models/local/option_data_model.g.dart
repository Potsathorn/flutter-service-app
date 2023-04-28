// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OptionDataModelAdapter extends TypeAdapter<OptionDataModel> {
  @override
  final int typeId = 0;

  @override
  OptionDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OptionDataModel(
      name: fields[0] as String,
      description: fields[1] as String,
      price: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, OptionDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
