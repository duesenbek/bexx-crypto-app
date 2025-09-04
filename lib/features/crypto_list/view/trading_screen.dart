import 'package:flutter/material.dart';

class CryptoTradingScreen extends StatelessWidget {
  const CryptoTradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C4C80),
        title: Text('Crypto Trading', style: TextStyle(color: Colors.white, fontSize: 27.0, fontWeight: FontWeight.w800)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,

      ),
      body: Center(
        child: Icon(  
          Icons.cached_sharp,
          size: 100.0,
          )

      ),
    );
  }
}
