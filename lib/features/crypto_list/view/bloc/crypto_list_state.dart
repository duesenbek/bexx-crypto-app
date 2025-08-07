part of 'crypto_list_bloc.dart';

abstract class CryptoListState extends Equatable {
  @override
  List<Object?> get props => [];
}
class CryptoListInitial extends CryptoListState {
  @override
  String toString() => 'CryptoListInitial';
}
class CryptoListLoading extends CryptoListState {
  @override
  String toString() => 'CryptoListLoading';
  @override
  List<Object?> get props => [];
}  

class CryptoListLoaded extends CryptoListState {
  final List<CryptoCoin> cryptoCoinsList;

  // Constructor to initialize the state with a list of CryptoCoin
  CryptoListLoaded(this.cryptoCoinsList);

  factory CryptoListLoaded.fromCoinsList(List<CryptoCoin> coinsList) {
    return CryptoListLoaded(coinsList);
  }
  @override
  List<Object?> get props => [cryptoCoinsList];
}
class CryptoListError extends CryptoListState {
  final String message;

  CryptoListError(this.message);
  @override
  List<Object?> get props => [message];
}