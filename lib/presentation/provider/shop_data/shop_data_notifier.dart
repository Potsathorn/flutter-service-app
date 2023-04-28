import 'package:flutter/cupertino.dart';
import 'package:service_app/domain/usecase/get_shop_data.dart';
import 'package:service_app/presentation/provider/shop_data/shop_data_state.dart';

class ShopDataNotifier with ChangeNotifier {
  final GetShopData _getCurrentShopData;
  ShopDataNotifier(this._getCurrentShopData);

  ShopDataState _shopDataState = ShopDataEmpty();
  ShopDataState get shopDataState => _shopDataState;

  Future<void> getShopData() async {
    _shopDataState = ShopDataLoading();
    await _getCurrentShopData.execute().then((result) => result.fold((failure) {
          _shopDataState = ShopDataError(failure.message);
          notifyListeners();
        }, (data) {
          _shopDataState = ShopDataHasData(data);
          notifyListeners();
        }));
  }
}
