import 'package:dartz/dartz.dart';
import 'package:service_app/data/failure.dart';
import 'package:service_app/domain/entities/shop_data.dart';
import 'package:service_app/domain/repositories/shop_data_repository.dart';

class GetShopData {
  final ShopDataRepository shopDataRepository;
  GetShopData(this.shopDataRepository);
  Future<Either<Failure, ShopData>> execute() =>
      shopDataRepository.getShopData();
}
