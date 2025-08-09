import 'package:flutter/material.dart';
import 'package:flutter_study_guide/features/crypto_list/view/crypto_list_screen.dart';


 class NavigationPanel extends StatelessWidget {
  NavigationPanel({super.key});
     int _currentIndex = 0;
     final List<Widget> _children = [
        CryptoListScreen(),
        Placeholder(), // Replace with your actual screens or import UserProfileScreen if it exists
        Placeholder(), // Replace with your actual screens or import CryptoTradingScreen if it exists
     ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          (context as Element).markNeedsBuild();
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Crypto List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Crypto Trading',
          ),  
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Profile',
          ),
          

          // Add more navigation items here as needed
        ],
      ),
    );
  }
}