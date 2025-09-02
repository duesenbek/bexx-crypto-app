import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'crypto_details.g.dart';

@JsonSerializable()
class CryptoDetails extends Equatable {
  @JsonKey(name: 'FROMSYMBOL')
  final String symbol;

  @JsonKey(name: 'LASTUPDATE', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime lastUpdate;

  @JsonKey(name: 'FULLNAME')
  final String? cryptoFullName;

  @JsonKey(name: 'IMAGEURL')
  final String? cryptoIcon;

  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @JsonKey(name: 'MKTCAP')
  final double marketCap;

  @JsonKey(name: 'VOLUME24HOUR')
  final double volume24h;

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
