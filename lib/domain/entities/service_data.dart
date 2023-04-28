import 'package:equatable/equatable.dart';
import 'package:service_app/data/models/local/option_data_model.dart';
import 'package:service_app/data/models/local/service_data_model.dart';
import 'dart:typed_data';
import 'package:service_app/domain/entities/option_data.dart';

class ServiceData extends Equatable {
  final String name;
  final String description;
  final String location;
  final String website;
  final bool isActive;
  final double price;
  final List<Uint8List> image;
  final List<OptionData> option;
  final String id;
  final DateTime time;

  const ServiceData({
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

  ServiceDataModel toModel() => ServiceDataModel(
      id: id,
      time: time,
      name: name,
      description: description,
      location: location,
      website: website,
      isActive: isActive,
      price: price,
      image: image,
      option: option
          .map((e) => OptionDataModel(
              name: e.name, description: e.description, price: e.price))
          .toList());

  @override
  List<Object?> get props => [
        name,
        description,
        location,
        website,
        isActive,
        price,
        image,
        option,
        id,
        time
      ];
}
