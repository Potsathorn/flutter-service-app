// To parse this JSON data, do
//
//     final baseResponseModel = baseResponseModelFromJson(jsonString);

import 'dart:convert';
import 'package:service_app/data/models/remote/shop_data_model.dart';

BaseResponseModel baseResponseModelFromJson(String str) =>
    BaseResponseModel.fromJson(json.decode(str));

String baseResponseModelToJson(BaseResponseModel data) =>
    json.encode(data.toJson());

class BaseResponseModel {
  final String status;
  final int results;
  final ShopDataModel data;

  BaseResponseModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel(
        status: json["status"],
        results: json["results"],
        data: ShopDataModel.fromJson(json["data"]["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "results": results,
        "data": data.toJson(),
      };
}
