// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoDetails _$CryptoDetailsFromJson(Map<String, dynamic> json) =>
    CryptoDetails(
      id: json['id'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      marketCap: (json['marketCap'] as num).toDouble(),
      volume24h: (json['volume24h'] as num).toDouble(),
      change24h: (json['change24h'] as num).toDouble(),
    );

Map<String, dynamic> _$CryptoDetailsToJson(CryptoDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'price': instance.price,
      'marketCap': instance.marketCap,
      'volume24h': instance.volume24h,
      'change24h': instance.change24h,
    };
