import 'dart:developer';

import 'package:service_app/data/datasources/local/local_data_source.dart';
import 'package:service_app/data/models/local/service_data_model.dart';
import 'package:service_app/domain/entities/option_data.dart';
import 'package:service_app/domain/entities/service_data.dart';
import 'package:service_app/domain/repositories/service_data_repository.dart';

class ServiceDataRepositoryImpl implements ServiceDataRepository {
  final LocalDataSource localDataSource;

  ServiceDataRepositoryImpl({required this.localDataSource});

  @override
  Future<ServiceData> deleteServiceData() {
    // TODO: implement deleteServiceData
    throw UnimplementedError();
  }

  @override
  Future<List<ServiceData>> getServiceData(
      {required int page, required int limit}) async {
    try {
      final serviceList =
          await localDataSource.getService(page: page, limit: limit);

      return serviceList.map((service) => service.toEntity()).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<int> insertServiceData({required ServiceData service}) async {
    try {
      await localDataSource.insertService(service: service.toModel());
      return 1;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ServiceData> updateServiceData() {
    // TODO: implement updateServiceData
    throw UnimplementedError();
  }
}
