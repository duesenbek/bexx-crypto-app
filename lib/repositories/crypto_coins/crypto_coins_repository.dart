
import 'package:dio/dio.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_study_guide/repositories/models/crypto_coin_model.dart';
import 'package:flutter_study_guide/repositories/models/crypto_details.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  Future<List<CryptoCoin>> getCoins() async {
    final response = await _dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,LTC,XRP,SOL&tsyms=USD',
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;

    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData = (e.value['USD'] as Map<String, dynamic>);
      final details = CryptoDetails.fromJson(usdData);

      return CryptoCoin(
        name: details.cryptoFullName ?? details.symbol,
        details: details,
      );
    }).toList();

    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin?> getCoin(String symbol) async {
    final response = await _dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$symbol&tsyms=USD',
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;

    if (!dataRaw.containsKey(symbol)) return null;

    final usdData = dataRaw[symbol]['USD'] as Map<String, dynamic>;
    final details = CryptoDetails.fromJson(usdData);

    return CryptoCoin(
      name: details.cryptoFullName ?? details.symbol,
      details: details,
    );
  }

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    return getCoins();
  }
}
