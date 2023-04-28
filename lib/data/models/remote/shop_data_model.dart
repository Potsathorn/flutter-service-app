import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:service_app/domain/entities/shop_data.dart';

ShopDataModel shopDataModelFromJson(String str) =>
    ShopDataModel.fromJson(json.decode(str));

String shopDataModelToJson(ShopDataModel data) => json.encode(data.toJson());

class ShopDataModel extends Equatable {
  final String shopId;
  final String shopName;
  final List<String> categories;
  final bool isOpen;
  final String openTime;
  final String closeTime;
  final String logoUrl;

  const ShopDataModel({
    required this.shopId,
    required this.shopName,
    required this.categories,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
    required this.logoUrl,
  });

  factory ShopDataModel.fromJson(Map<String, dynamic> json) => ShopDataModel(
        shopId: json["shopId"],
        shopName: json["shopName"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        isOpen: json["isOpen"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        logoUrl: json["logoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "shopId": shopId,
        "shopName": shopName,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "isOpen": isOpen,
        "openTime": openTime,
        "closeTime": closeTime,
        "logoUrl": logoUrl,
      };

  ShopData toEntity() => ShopData(
      shopId: shopId,
      shopName: shopName,
      categories: categories,
      isOpen: isOpen,
      openTime: openTime,
      closeTime: closeTime,
      logoUrl: logoUrl);

  @override
  List<Object?> get props =>
      [shopId, shopName, categories, isOpen, openTime, closeTime, logoUrl];
}
