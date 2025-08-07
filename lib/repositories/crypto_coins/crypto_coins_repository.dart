

import 'package:dio/dio.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_study_guide/repositories/models/crypto_coin_model.dart';
class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<CryptoCoin>> getCoins() async {
    final response = await _dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,LTC,XRP,SOL,RESOLV,S&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData = (e.value['USD'] as Map<String, dynamic>);
      final priceInUSD = usdData['PRICE']?.toString() ?? '0';
      final coinSymbol = usdData['FROMSYMBOL']?.toString() ?? 'Undefined';
      final cryptoIcon = usdData['IMAGEURL'] != null
          ? 'https://www.cryptocompare.com' + usdData['IMAGEURL']
          : null;
      final coinName = usdData['FROMSYMBOL']?.toString() ?? 'Undefined';
      final coinFullName = usdData['FULLNAME']?.toString() ?? 'Undefined';
      return CryptoCoin(
        priceInUSD: priceInUSD,
        coinSymbol: coinSymbol,
        cryptoIcon: cryptoIcon,
        name: coinName,
        coinFullName: coinFullName,
      );
    }).toList();

    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin?> getCoin(String symbol) async {
    final response = await _dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$symbol&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoId = data['DISPLAY'] as Map<String, dynamic>;
    if (cryptoId.isEmpty) return null;
    if (dataRaw.isEmpty) return null;

    if (!dataRaw.containsKey(symbol)) return null;
    final usdData = (dataRaw[symbol]['USD'] as Map<String, dynamic>);
    final priceInUSD = usdData['PRICE']?.toString() ?? '0';
    final coinSymbol = usdData['FROMSYMBOL']?.toString() ?? 'Undefined';
    final cryptoIcon = usdData['IMAGEURL'] != null
        ? 'https://www.cryptocompare.com' + usdData['IMAGEURL']
        : null;
    final coinName = usdData['FROMSYMBOL']?.toString() ?? 'Undefined';
    final coinFullName = usdData['FULLNAME']?.toString() ?? 'Undefined';
    final low = usdData['LOW24HOUR']?.toString() ?? '0';
    final high = usdData['HIGH24HOUR']?.toString() ?? '0';
    final marketCap = usdData['MKTCAP']?.toString() ?? '0';
    final volume24h = usdData['VOLUME24HOUR']?.toString() ?? '0';
    final change30min = usdData['CHANGEPCT30MIN']?.toString() ?? '0';
    final change1h = usdData['CHANGEPCT1HOUR']?.toString() ?? '0';
    final change24h = usdData['CHANGEPCT24HOUR']?.toString() ?? '0';
    final change7d = usdData['CHANGEPCT7DAYS']?.toString() ?? '0';
    final change30d = usdData['CHANGEPCT30DAYS']?.toString() ?? '0';
   
    return CryptoCoin(
      priceInUSD: priceInUSD,
      coinSymbol: coinSymbol,
      cryptoIcon: cryptoIcon,
      name: coinName,
      coinFullName: coinFullName,
      low: low,
      high: high,     
      marketCap: marketCap,
      volume24h: volume24h,

      change30min: change30min,
      change1h: change1h, 

      change24h: change24h,
      change7d: change7d,
      change30d: change30d,
      
    );
  }

  // Optionally keep this if you use it elsewhere, otherwise remove
  Future<List<CryptoCoin>> getCoinsList() async {
    return getCoins();
  }
}
