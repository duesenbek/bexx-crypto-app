part of 'crypto_list_bloc.dart';
abstract class CryptoListEvent {}
class LoadCryptoList extends CryptoListEvent {
  final Completer<void>? completer;

  LoadCryptoList([this.completer]);

  @override
  String toString() => 'LoadCryptoList';
}
  
