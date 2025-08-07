import 'package:flutter/material.dart';

class CryptoTradingScreen extends StatelessWidget {
  const CryptoTradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Trading'),
      ),
      body: Center(
        child: Text('Crypto Trading Screen'),
      ),
    );
  }
}
