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
      leading: cryptoIcon.isNotEmpty
          ? Image.network(
              cryptoIcon,
              width: 40.0,
              height: 40.0,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 40.0);
              },
            )
          : const Icon(Icons.error, size: 40.0),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/cryptoCoin',
          arguments: {
            'coinName': coinName,
            'coinPrice': coinPrice,
            'coinIcon': cryptoIcon,
            'coinSymbol': coinSymbol,
            'coinFullName': coinFullName,
          },
        );
      },
    );
  }
}