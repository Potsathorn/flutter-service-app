import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:service_app/domain/entities/service_data.dart';
import 'package:service_app/domain/usecase/crud_service_data.dart';

class ServiceDataNotifier with ChangeNotifier {
  final CrudServiceData _crudServiceData;
  ServiceDataNotifier(this._crudServiceData);
  int _page = 1;
  int _limit = 10;
  List<ServiceData> _serviceDataList = [];
  List<ServiceData> get serviceDataList => _serviceDataList;

  void clearService() {
    _serviceDataList.clear();
  }

  void sortByName() {
    _serviceDataList
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    notifyListeners();
  }

  void sortByTime() {
    _serviceDataList.sort((b, a) => a.time.compareTo(b.time));
    notifyListeners();
  }

  void updateStatus({required int index, required bool status}) {
    ServiceData service = _serviceDataList[index];
    ServiceData updatedService = ServiceData(
        id: service.id,
        time: service.time,
        name: service.name,
        description: service.description,
        location: service.location,
        website: service.website,
        isActive: status,
        price: service.price,
        image: [],
        option: []);
    updateServiceData(updatedService);
    clearService();
    getServiceData();
  }

  Future<void> getServiceData() async {
    log("get page #$_page");
    await _crudServiceData.get(page: _page, limit: _limit).then((value) {
      if (value.length < _limit) {
        //is last page
        _serviceDataList.addAll(value);
        notifyListeners();
      } else {
        _serviceDataList.addAll(value);
        _page++;
        getServiceData();
        notifyListeners();
      }
    });
  }

  Future<void> insertServiceData(ServiceData service) async {
    log("insert");
    await _crudServiceData.insert(service: service).then((value) async {
      {
        // _serviceDataList.clear();
        // await getServiceData();
        // notifyListeners();
      }
    });
  }

  Future<void> updateServiceData(ServiceData service) async {
    log("update");
    await _crudServiceData.update(service: service).then((value) async {
      {
        // await getServiceData();
        // notifyListeners();
      }
    });
  }

  Future<void> deleteServiceData(String key) async {
    log("delete");
    await _crudServiceData.delete(key: key).then((value) async {
      {
        _serviceDataList.clear();
        // await getServiceData();
        // notifyListeners();
      }
    });
  }
}
