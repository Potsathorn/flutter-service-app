import 'package:equatable/equatable.dart';
import 'package:service_app/domain/entities/shop_data.dart';

abstract class ShopDataState extends Equatable {
  const ShopDataState();
  @override
  List<Object?> get props => [];
}

class ShopDataEmpty extends ShopDataState {}

class ShopDataLoading extends ShopDataState {}

class ShopDataError extends ShopDataState {
  final String message;
  const ShopDataError(this.message);

  @override
  List<Object?> get props => [message];
}

class ShopDataHasData extends ShopDataState {
  final ShopData shopData;
  const ShopDataHasData(this.shopData);

  @override
  List<Object?> get props => [shopData];
}
