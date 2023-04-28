import 'dart:convert';

import 'package:service_app/data/constans.dart';
import 'package:service_app/data/exception.dart';
import 'package:service_app/data/models/remote/base_response_model.dart';
import 'package:service_app/data/models/remote/shop_data_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<ShopDataModel> getShopData();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<ShopDataModel> getShopData() async {
    final response = await client.get(Uri.parse(Config.baseUrl));
    if (response.statusCode == 200) {
      return BaseResponseModel.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }
}
