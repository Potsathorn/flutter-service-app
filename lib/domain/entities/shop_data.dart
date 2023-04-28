import 'package:equatable/equatable.dart';

class ShopData extends Equatable {
  final String shopId;
  final String shopName;
  final List<String> categories;
  final bool isOpen;
  final String openTime;
  final String closeTime;
  final String logoUrl;

  const ShopData({
    required this.shopId,
    required this.shopName,
    required this.categories,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
    required this.logoUrl,
  });

  @override
  List<Object?> get props =>
      [shopId, shopName, categories, isOpen, openTime, closeTime, logoUrl];
}
