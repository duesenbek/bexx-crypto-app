import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_study_guide/repositories/models/crypto_coin_model.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart';
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
    } catch (e, st) {
      emit(CryptoCoinError(e.toString()));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}