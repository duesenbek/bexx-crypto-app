
import 'package:dio/dio.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_study_guide/repositories/models/crypto_coin_model.dart';
import 'package:flutter_study_guide/repositories/models/crypto_details.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker/talker.dart';
class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required Dio dio,
    required this.cryptoCoinsBox,
  }) : _dio = dio;


  final Dio _dio;
  final Box<CryptoCoin> cryptoCoinsBox;
  registerCryptoCoin(CryptoCoin cryptoCoin) => cryptoCoinsBox.put(cryptoCoin.name, cryptoCoin);
  Future<List<CryptoCoin>> getCoins() async {
    var cryptoCoinsList = cryptoCoinsBox.values.toList();
    try {
   List<CryptoCoin> cryptoCoinsList = await _fetchCoinsListFromApi();
    final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
  await cryptoCoinsBox.putAll(cryptoCoinsMap);
} on Exception catch (e, st) {
  GetIt.instance<Talker>().handle(e, st);
  cryptoCoinsList = cryptoCoinsBox.values.toList();
}
cryptoCoinsList.sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));
return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await _dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,LTC,XRP,SOL,TRX,DOGE,ADA,AVAX,MATIC,AID,CAG&tsyms=USD',
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
    try {
  final coin = await _fetchCoinDetailsFromApi(symbol);
  if (coin != null) {
    cryptoCoinsBox.put(symbol, coin);
  }
  return coin;
} on Exception catch (e, st) {
   GetIt.instance<Talker>().handle(e, st);
   cryptoCoinsBox.containsKey(symbol);
  return cryptoCoinsBox.get(symbol);
}

  }

  Future<CryptoCoin?> _fetchCoinDetailsFromApi(String symbol) async {
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
