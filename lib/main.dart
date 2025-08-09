import 'package:flutter/material.dart';
import 'package:flutter_study_guide/core/view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/bloc/crypto_coin_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'dart:async';
// Ensure that the file 'abstract_coins_repository.dart' exists and defines 'AbstractCoinsRepository'

void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('App started with TalkerFlutter');
  GetIt.I<Talker>().info('Initializing dependencies');


  GetIt.I.registerSingleton<AbstractCoinsRepository>(CryptoCoinsRepository(dio: Dio()));
  
  // Создаем экземпляр CryptoCoinBloc
  final cryptoCoinBloc = CryptoCoinBloc(repository: GetIt.I<AbstractCoinsRepository>());
  FlutterError.onError = (details) {
    GetIt.I<Talker>().handle(details.exception, details.stack);
  };
  runZonedGuarded(
    () => runApp(CryptoCurrencyApp(cryptoCoinBloc: cryptoCoinBloc)),
    (error, stackTrace) {
      GetIt.I<Talker>().handle(error, stackTrace);
    },
  );

}



  
