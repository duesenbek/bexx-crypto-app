import 'package:flutter/material.dart';
import 'package:flutter_study_guide/core/view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/bloc/crypto_coin_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'dart:async';
import 'package:talker_dio_logger/talker_dio_logger.dart';
// Ensure that the file 'abstract_coins_repository.dart' exists and defines 'AbstractCoinsRepository'
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('App started with TalkerFlutter');
  GetIt.I<Talker>().info('Initializing dependencies');
  final dio = Dio();
  dio.interceptors.add(TalkerDioLogger(talker: talker,settings: TalkerDioLoggerSettings(
    printResponseData: false, 
  )));
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: TalkerBlocLoggerSettings(
       printStateFullData: false,
       printEventFullData: false,
      
    )
  );
  GetIt.I.registerSingleton<AbstractCoinsRepository>(
    CryptoCoinsRepository(dio: dio),
  ); 
  FlutterError.onError = (details) {
    GetIt.I<Talker>().handle(details.exception, details.stack);
  };
  runZonedGuarded(
    () => runApp(CryptoCurrencyApp(cryptoCoinBloc: CryptoCoinBloc(
      repository: GetIt.I<AbstractCoinsRepository>(),
    ))),
    (error, stackTrace) {
      GetIt.I<Talker>().handle(error, stackTrace);
    },
  );

}


  
