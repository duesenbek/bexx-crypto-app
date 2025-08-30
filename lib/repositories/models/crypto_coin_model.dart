import 'package:equatable/equatable.dart';
import 'crypto_details.dart';

class CryptoCoin extends Equatable {
  final String name;
  final CryptoDetails details;

  const CryptoCoin({
    required this.name,
    required this.details,
  });

  @override
  List<Object?> get props => [name, details];
}
