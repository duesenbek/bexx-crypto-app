import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import 'package:hive_flutter/hive_flutter.dart';
part 'crypto_details.g.dart';
@HiveType(typeId: 1)
@JsonSerializable()
class CryptoDetails extends Equatable {
  @HiveField(0)
  @JsonKey(name: 'FROMSYMBOL')
  final String symbol;

  @HiveField(1)
  @JsonKey(name: 'LASTUPDATE', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime lastUpdate;

  @HiveField(2)
  @JsonKey(name: 'FULLNAME')
  final String? cryptoFullName;

  @HiveField(3)
  @JsonKey(name: 'IMAGEURL')
  final String? cryptoIcon;

  @HiveField(4)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @HiveField(5)
  @JsonKey(name: 'MKTCAP')
  final double marketCap;

  @HiveField(6)
  @JsonKey(name: 'VOLUME24HOUR')
  final double volume24h;

  @HiveField(7)
  @JsonKey(name: 'CHANGEPCT24HOUR')
  final double change24h;

  const CryptoDetails({
    required this.symbol,
    this.cryptoFullName,
    this.cryptoIcon,
    required this.priceInUSD,
    required this.marketCap,
    required this.volume24h,
    required this.change24h,
    required this.lastUpdate,
  });

  factory CryptoDetails.fromJson(Map<String, dynamic> json) =>
      _$CryptoDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoDetailsToJson(this);

  static DateTime _dateTimeFromJson(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  
  static int _dateTimeToJson(DateTime time) =>
      (time.millisecondsSinceEpoch / 1000).round();
  @override
  List<Object?> get props => [
        symbol,
        cryptoFullName,
        cryptoIcon,
        priceInUSD,
        marketCap,
        volume24h,
        lastUpdate,
        change24h,
      ];
}
