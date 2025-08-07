part of 'crypto_coin_bloc.dart';


class CryptoCoinEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadCryptoCoin extends CryptoCoinEvent {
  final String coinId;

  LoadCryptoCoin(this.coinId);

  @override
  List<Object?> get props => [coinId];
}