import 'package:bloc/bloc.dart';
import 'package:flutter_study_guide/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_study_guide/repositories/models/crypto_coin_model.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:get_it/get_it.dart';
part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  final AbstractCoinsRepository _coinsRepository;

  CryptoListBloc(this._coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {

      emit(CryptoListLoading()); 
      try {
        if (state is! CryptoListLoading) {
          emit(CryptoListLoading());
        
        }
        
        final cryptoCoinsList = await _coinsRepository.getCoinsList();
        
        emit(CryptoListLoaded(cryptoCoinsList));
      } catch (e, st) {
        emit(CryptoListError('Failed to load crypto coins: $e'));
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });
  }
}
