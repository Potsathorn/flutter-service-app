import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:service_app/data/models/local/option_data_model.dart';
import 'package:service_app/domain/entities/option_data.dart';
import 'package:service_app/domain/entities/service_data.dart';

part 'service_data_model.g.dart';

@HiveType(typeId: 1)
class ServiceDataModel extends Equatable {
  static const String boxKey = 'service';
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late String location;
  @HiveField(3)
  late String website;
  @HiveField(4)
  late bool isActive;
  @HiveField(5)
  late double price;
  @HiveField(6)
  late List<Uint8List> image;
  @HiveField(7)
  late List<OptionDataModel> option;
  @HiveField(8)
  late String id;
  @HiveField(9)
  late DateTime time;

  ServiceDataModel({
    required this.name,
    required this.description,
    required this.location,
    required this.website,
    required this.isActive,
    required this.price,
    required this.image,
    required this.option,
    required this.id,
    required this.time,
  });

  ServiceData toEntity() => ServiceData(
      name: name,
      description: description,
      location: location,
      website: website,
      isActive: isActive,
      price: price,
      image: image,
      option: option.map((model) => model.toEntity()).toList(),
      id: id,
      time: time);

  ServiceDataModel toModel(ServiceData entity) => ServiceDataModel(
      id: entity.id,
      time: entity.time,
      name: entity.name,
      description: entity.description,
      location: entity.location,
      website: entity.website,
      isActive: entity.isActive,
      price: entity.price,
      image: entity.image,
      option: entity.option
          .map((e) => OptionDataModel(
              name: e.name, description: e.description, price: e.price))
          .toList());

  @override
  List<Object?> get props =>
      [name, description, location, website, isActive, price, image, option];
}
