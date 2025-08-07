import 'package:flutter_study_guide/repositories/models/crypto_coin_model.dart';

abstract class AbstractCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoin?> getCoin(String id);

}
