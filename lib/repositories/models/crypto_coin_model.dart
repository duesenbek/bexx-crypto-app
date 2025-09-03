import 'package:equatable/equatable.dart';
import 'crypto_details.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'crypto_coin_model.g.dart';

@HiveType(typeId: 2)
class CryptoCoin extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final CryptoDetails details;

  const CryptoCoin({
    required this.name,
    required this.details,
  });

  @override
  List<Object?> get props => [name, details];
}
