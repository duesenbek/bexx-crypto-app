// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoDetails _$CryptoDetailsFromJson(Map<String, dynamic> json) =>
    CryptoDetails(
      symbol: json['FROMSYMBOL'] as String,
      cryptoFullName: json['FULLNAME'] as String?,
      cryptoIcon: json['IMAGEURL'] as String?,
      priceInUSD: (json['PRICE'] as num).toDouble(),
      marketCap: (json['MKTCAP'] as num).toDouble(),
      volume24h: (json['VOLUME24HOUR'] as num).toDouble(),
      change24h: (json['CHANGEPCT24HOUR'] as num).toDouble(),
    );

Map<String, dynamic> _$CryptoDetailsToJson(CryptoDetails instance) =>
    <String, dynamic>{
      'FROMSYMBOL': instance.symbol,
      'FULLNAME': instance.cryptoFullName,
      'IMAGEURL': instance.cryptoIcon,
      'PRICE': instance.priceInUSD,
      'MKTCAP': instance.marketCap,
      'VOLUME24HOUR': instance.volume24h,
      'CHANGEPCT24HOUR': instance.change24h,
    };
