# Flutter Study Guide - Bloc без провайдеров

Этот проект демонстрирует использование flutter_bloc без BlocProvider, MultiBlocProvider или любых других провайдеров. Bloc передается напрямую через конструкторы виджетов.

## Архитектура

### 1. main.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_study_guide/core/view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/bloc/crypto_coin_bloc.dart';

void main() {
  GetIt.I.registerSingleton<AbstractCoinsRepository>(CryptoCoinsRepository(dio: Dio()));
  
  // Создаем экземпляр CryptoCoinBloc
  final cryptoCoinBloc = CryptoCoinBloc(repository: GetIt.I<AbstractCoinsRepository>());
  
  runApp(CryptoCurrencyApp(cryptoCoinBloc: cryptoCoinBloc));
}
```

### 2. app.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_study_guide/core/view.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/bloc/crypto_coin_bloc.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/crypto_coin_screen.dart';

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
        onGenerateRoute: (settings) {
          if (settings.name == '/cryptoCoin') {
            return MaterialPageRoute(
              builder: (context) => CryptoCoinScreen(cryptoCoinBloc: cryptoCoinBloc),
              settings: settings,
            );
          }
          return null;
        },
    );
  }
}
```

### 3. CryptoCoinBloc
```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_study_guide/repositories/models/crypto_coin_model.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';
part 'time_interval.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  final AbstractCoinsRepository repository;

  CryptoCoinBloc({required this.repository}) : super(CryptoCoinInitial()) {
    on<LoadCryptoCoin>(_onLoadCryptoCoin);
  }

  Future<void> _onLoadCryptoCoin(
    LoadCryptoCoin event,
    Emitter<CryptoCoinState> emit,
  ) async {
    emit(CryptoCoinLoading());
    try {
      final coin = await repository.getCoin(event.coinId);
      if (coin != null) {
        emit(CryptoCoinLoaded(coin));
      } else {
        emit(CryptoCoinError('Coin not found'));
      }
    } catch (e) {
      emit(CryptoCoinError(e.toString()));
    }
  }
}
```

### 4. CryptoCoinScreen
```dart
import 'package:flutter/material.dart';
import 'package:flutter_study_guide/repositories/models/crypto_coin_model.dart';
import 'package:flutter_study_guide/features/crypto_coin_screen/bloc/crypto_coin_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoCoinScreen extends StatefulWidget {
  final CryptoCoinBloc cryptoCoinBloc;
  
  const CryptoCoinScreen({
    super.key,
    required this.cryptoCoinBloc,
  });

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  @override
  void initState() {
    super.initState();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final coinName = args?['coinName'] ?? '';
    if (coinName.isNotEmpty) {
      widget.cryptoCoinBloc.add(LoadCryptoCoin(coinName));
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final coinName = args?['coinName'] ?? 'Unknown Coin';
    final coinIcon = args?['coinIcon'] ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C4C80),
        title: Row(
          children: [
            if (coinIcon.isNotEmpty)
              Image.network(
                coinIcon,
                width: 40.0,
                height: 40.0,
              ),
            const SizedBox(width: 8.0),
            Text(
              coinName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 27.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
        bloc: widget.cryptoCoinBloc, // Важно! Указываем bloc параметр
        builder: (context, state) {
          if (state is CryptoCoinLoaded) {
            final coin = state.coin;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (coin.cryptoIcon != null)
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: Image.network(coin.cryptoIcon!),
                    )
                  else
                    const SizedBox(
                      height: 160,
                      width: 160,
                      child: Icon(
                        Icons.error,
                        size: 100.0,
                        color: Colors.grey,
                      ),
                    ),
                  const SizedBox(height: 24),
                  Text(
                    coin.coinFullName ?? coinName,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BaseCard(
                    child: Center(
                      child: Text(
                        '\$${coin.priceInUSD}',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  if (coin.high != null && coin.low != null)
                    BaseCard(
                      child: Column(
                        children: [
                          _DataRow(
                            title: 'High 24 Hour',
                            value: '\$${coin.high}',
                          ),
                          const SizedBox(height: 6),
                          _DataRow(
                            title: 'Low 24 Hour',
                            value: '\$${coin.low}',
                          ),
                        ],
                      ),
                    ),
                  if (coin.change24h != null)
                    BaseCard(
                      child: _DataRow(
                        title: '24h Change',
                        value: '${coin.change24h}%',
                      ),
                    ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
```

## Ключевые особенности

1. **Нет провайдеров**: Не используется BlocProvider, MultiBlocProvider или любые другие провайдеры
2. **Прямая передача**: Bloc передается через конструкторы виджетов
3. **BlocBuilder с параметром bloc**: Обязательно указывается параметр `bloc:` в BlocBuilder
4. **Создание в main.dart**: Экземпляр bloc создается в main.dart и передается в приложение
5. **onGenerateRoute**: Используется для передачи bloc в экраны через роутинг

## Преимущества

- Явная зависимость: видно, какие bloc используются в каждом виджете
- Нет магии контекста: не нужно искать bloc через context.read/context.watch
- Простота тестирования: легко мокать bloc для тестов
- Контроль жизненного цикла: полный контроль над созданием и уничтожением bloc
#   b a s i c - c r y p t o - a p p  
 #   b a s i c - c r y p t o - a p p  
 #   c r y p t o - a p p  
 #   c r y p t o - a p p  
 #   d u e s e n b e k - c r y p t o - a p p  
 #   d u e s e n b e k - c r y p t o - a p p  
 #   d u e s e n b e k - c r y p t o - a p p  
 #   d u e s e n b e k - c r y p t o - a p p  
 #   d u e s e n b e k - c r y p t o - a p p  
 #   d u e s e n b e k - c r y p t o - a p p  
 #   b e x x - c r y p t o - a p p  
 #   b e x x - c r y p t o - a p p  
 #   b e x x - c r y p t o - a p p  
 