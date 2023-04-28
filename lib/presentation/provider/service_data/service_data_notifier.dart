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

  Future<void> getServiceData() async {
    log("get page #$_page");
    await _crudServiceData.get(page: _page, limit: _limit).then((value) async {
      if (value.length < _limit) {
        //is last page
        _serviceDataList.addAll(value);
        notifyListeners();
      } else {
        _serviceDataList.addAll(value);
        _page++;
        await getServiceData();
        notifyListeners();
      }
    });
  }

  Future<void> insertServiceData(ServiceData service) async {
    log("insert");
    await _crudServiceData.insert(service: service).then((value) async {
      {
        _serviceDataList.clear();
        await getServiceData();
        notifyListeners();
      }
    });
  }
}
