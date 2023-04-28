import 'package:dartz/dartz.dart';
import 'package:service_app/data/failure.dart';
import 'package:service_app/domain/entities/shop_data.dart';

abstract class ShopDataRepository {
  Future<Either<Failure, ShopData>> getShopData();
}
