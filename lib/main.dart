import 'package:flutter/material.dart';
import 'package:flutter_study_guide/core/view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/bloc/crypto_coin_bloc.dart';

// Ensure that the file 'abstract_coins_repository.dart' exists and defines 'AbstractCoinsRepository'

void main() {
  GetIt.I.registerSingleton<AbstractCoinsRepository>(CryptoCoinsRepository(dio: Dio()));
  
  // Создаем экземпляр CryptoCoinBloc
  final cryptoCoinBloc = CryptoCoinBloc(repository: GetIt.I<AbstractCoinsRepository>());
  
  runApp(CryptoCurrencyApp(cryptoCoinBloc: cryptoCoinBloc));
}



  
