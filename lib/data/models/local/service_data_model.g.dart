// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceDataModelAdapter extends TypeAdapter<ServiceDataModel> {
  @override
  final int typeId = 1;

  @override
  ServiceDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceDataModel(
      name: fields[0] as String,
      description: fields[1] as String,
      location: fields[2] as String,
      website: fields[3] as String,
      isActive: fields[4] as bool,
      price: fields[5] as double,
      image: (fields[6] as List).cast<Uint8List>(),
      option: (fields[7] as List).cast<OptionDataModel>(),
      id: fields[8] as String,
      time: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceDataModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.website)
      ..writeByte(4)
      ..write(obj.isActive)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.option)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
