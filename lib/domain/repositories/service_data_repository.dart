import 'package:service_app/domain/entities/service_data.dart';

abstract class ServiceDataRepository {
  //create
  Future<int> insertServiceData({required ServiceData service});

  //read
  Future<List<ServiceData>> getServiceData(
      {required int page, required int limit});

  //update
  Future<ServiceData> updateServiceData();

  //delete
  Future<ServiceData> deleteServiceData();
}
