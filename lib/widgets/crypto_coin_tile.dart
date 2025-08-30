import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  final String coinName;
  final String coinPrice;
  final String cryptoIcon;
  final String coinSymbol;
  final String coinFullName;

  const CryptoCoinTile({
    super.key,
    required this.coinName,
    required this.coinPrice,
    required this.cryptoIcon,
    required this.coinSymbol,
    required this.coinFullName,
  });

  @override
  Widget build(BuildContext context) {
    // Добавляем базовый URL, если иконка начинается с "/"
    final iconUrl = cryptoIcon.isNotEmpty
        ? (cryptoIcon.startsWith('/')
            ? "https://www.cryptocompare.com$cryptoIcon"
            : cryptoIcon)
        : "";

    return ListTile(
      title: Text(
        coinName,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
      ),
      subtitle: Text(
        coinPrice,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16.0,
        ),
      ),
      leading: iconUrl.isNotEmpty
          ? Image.network(
              iconUrl,
              width: 40.0,
              height: 40.0,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 40.0);
              },
            )
          : const Icon(Icons.error, size: 40.0),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 20.0,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/cryptoCoin',
          arguments: {
            'coinName': coinName,
            'coinPrice': coinPrice,
            'coinIcon': iconUrl,
            'coinSymbol': coinSymbol,
            'coinFullName': coinFullName,
          },
        );
      },
    );
  }
}
