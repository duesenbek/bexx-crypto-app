part of 'crypto_coin_bloc.dart';


class CryptoCoinState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CryptoCoinInitial extends CryptoCoinState {}

class CryptoCoinLoading extends CryptoCoinState {}

class CryptoCoinLoaded extends CryptoCoinState {
  final CryptoCoin coin;

  CryptoCoinLoaded(this.coin);

  @override
  List<Object?> get props => [coin];
}

class CryptoCoinError extends CryptoCoinState {
  final String message;

  CryptoCoinError(this.message);

  @override
  List<Object?> get props => [message];
}