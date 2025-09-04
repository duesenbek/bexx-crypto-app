import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile', style: TextStyle(color: Colors.white, fontSize: 27.0, fontWeight: FontWeight.w800)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0C4C80),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),

      ),
      body: const Center(
       child: Icon(  
          Icons.person,
          size: 100.0,
          )

      ),
    );
  }
}