import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  final String name;
  final String priceInUSD;
  final String? coinSymbol;
  final String? cryptoIcon;
  final String? coinFullName;
  final String? low;
  final String? high;
  final String? marketCap;
  final String? volume24h;
  final String? change30min;
  final String? change1h;
  final String? change24h;
  final String? change7d;
  final String? change30d;

  const CryptoCoin({
    required this.name,
    required this.priceInUSD,
    this.coinSymbol,
    this.cryptoIcon,
    this.coinFullName,
    this.low,
    this.high,
    this.marketCap,
    this.volume24h,
    this.change30min,
    this.change1h,
    this.change24h,
    this.change7d,
    this.change30d,
  });

  @override
  List<Object?> get props => [
        name,
        priceInUSD,
        coinSymbol,
        cryptoIcon,
        coinFullName,
        low,
        high,
        marketCap,
        volume24h,
        change30min,
        change1h,
        change24h,
        change7d,
        change30d,
      ];
}