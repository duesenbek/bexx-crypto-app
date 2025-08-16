import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'crypto_details.g.dart';

@JsonSerializable()
class CryptoDetails extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final double price;
  final double marketCap;
  final double volume24h;
  final double change24h;

  CryptoDetails({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.marketCap,
    required this.volume24h,
    required this.change24h,
  });

  factory CryptoDetails.fromJson(Map<String, dynamic> json) =>
      _$CryptoDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoDetailsToJson(this);
  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        price,
        marketCap,
        volume24h,
        change24h,
      ];
}
