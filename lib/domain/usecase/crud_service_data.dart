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
  Future<int> update({required ServiceData service}) =>
      serviceDataRepository.updateServiceData(service: service);

  //delete
  Future<int> delete({required String key}) =>
      serviceDataRepository.deleteServiceData(key: key);
}
