import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:service_app/domain/entities/option_data.dart';

part 'option_data_model.g.dart';

@HiveType(typeId: 0)
class OptionDataModel extends Equatable {
  static const String boxKey = 'option';
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final double price;

  const OptionDataModel({
    required this.name,
    required this.description,
    required this.price,
  });

  OptionData toEntity() => OptionData(
        name: name,
        description: description,
        price: price,
      );

  OptionDataModel toModel(OptionData entity) => OptionDataModel(
        name: entity.name,
        description: entity.description,
        price: entity.price,
      );

  @override
  List<Object?> get props => [name, description, price];
}
