import 'dart:io';

import 'package:service_app/data/datasources/remote/remote_data_source.dart';
import 'package:service_app/data/exception.dart';
import 'package:service_app/domain/entities/shop_data.dart';
import 'package:service_app/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:service_app/domain/repositories/shop_data_repository.dart';

class ShopDataRepositoryImpl implements ShopDataRepository {
  final RemoteDataSource remoteDataSource;
  ShopDataRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ShopData>> getShopData() async {
    try {
      final result = await remoteDataSource.getShopData();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Failed to connect to server'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
