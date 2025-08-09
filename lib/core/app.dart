import 'package:flutter/material.dart';
import 'package:flutter_study_guide/core/view.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/bloc/crypto_coin_bloc.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/crypto_coin_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
class CryptoCurrencyApp extends StatelessWidget {
  final CryptoCoinBloc cryptoCoinBloc;

  const CryptoCurrencyApp({super.key, required this.cryptoCoinBloc});
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: 'Crypto Currency App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        routes: routes,
        navigatorObservers: [
          TalkerRouteObserver(GetIt.I<Talker>()),
        ],
        onGenerateRoute: (settings) {
          if (settings.name == '/cryptoCoin') {
            return MaterialPageRoute(
              builder: (context) => CryptoCoinScreen(cryptoCoinBloc: cryptoCoinBloc),
              settings: settings,
            );
          }
          // Возвращаем страницу ошибки для неизвестных роутов
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('Ошибка')),
              body: const Center(
                child: Text('Страница не найдена'),
              ),
            ),
          );
        },
    );
  }
}
