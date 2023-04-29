import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:service_app/data/models/local/option_data_model.dart';
import 'package:service_app/data/models/local/service_data_model.dart';

abstract class LocalDataSource {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter<ServiceDataModel>(ServiceDataModelAdapter());
    Hive.registerAdapter<OptionDataModel>(OptionDataModelAdapter());

    await Hive.openBox<ServiceDataModel>(ServiceDataModel.boxKey);
    await Hive.openBox<OptionDataModel>(OptionDataModel.boxKey);
  }

  Future<List<ServiceDataModel>> getService(
      {required int page, required int limit});

  Future<int> insertService({required ServiceDataModel service});

  Future<int> updateService({required ServiceDataModel service});

  Future<int> deleteService({required String key});
}

class LocalDataSourceImpl implements LocalDataSource {
  String _generateRandomKey() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        4, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  @override
  Future<List<ServiceDataModel>> getService(
      {required int page, required int limit}) async {
    final serviceBox = Hive.box<ServiceDataModel>(ServiceDataModel.boxKey);
    final totalServiceCount = serviceBox.length;
    final start = (page - 1) * limit;
    final newServiceCount =
        totalServiceCount - start < limit ? totalServiceCount - start : limit;
    final serviceList = List.generate(
            newServiceCount, (index) => serviceBox.getAt(start + index))
        .whereType<ServiceDataModel>()
        .toList();
    return serviceList;
  }

  @override
  Future<int> insertService({required ServiceDataModel service}) async {
    final serviceBox = Hive.box<ServiceDataModel>(ServiceDataModel.boxKey);
    late String id;
    do {
      id = _generateRandomKey();
    } while (serviceBox.containsKey(id));
    service.id = id;
    serviceBox.put(id, service);
    return 1;
  }

  @override
  Future<int> updateService({required ServiceDataModel service}) async {
    final serviceBox = Hive.box<ServiceDataModel>(ServiceDataModel.boxKey);
    serviceBox.put(service.id, service);
    return 1;
  }

  @override
  Future<int> deleteService({required String key}) async {
    final serviceBox = Hive.box<ServiceDataModel>(ServiceDataModel.boxKey);
    serviceBox.delete(key);
    return 1;
  }
}
