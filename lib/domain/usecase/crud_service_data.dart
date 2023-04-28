import 'package:service_app/domain/entities/service_data.dart';
import 'package:service_app/domain/repositories/service_data_repository.dart';

class CrudServiceData {
  final ServiceDataRepository serviceDataRepository;
  CrudServiceData(this.serviceDataRepository);

  //create
  Future<int> insert({required ServiceData service}) =>
      serviceDataRepository.insertServiceData(service: service);

  //read
  Future<List<ServiceData>> get({required int page, required int limit}) =>
      serviceDataRepository.getServiceData(page: page, limit: limit);

  //update
  Future<ServiceData> update() => serviceDataRepository.updateServiceData();

  //delete
  Future<ServiceData> delete() => serviceDataRepository.deleteServiceData();
}
