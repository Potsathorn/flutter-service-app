import 'package:equatable/equatable.dart';

class OptionData extends Equatable {
  final String name;
  final String description;
  final double price;

  const OptionData({
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  List<Object?> get props => [name, description, price];
}
