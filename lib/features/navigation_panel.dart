import 'package:flutter/material.dart';
import 'package:flutter_study_guide/features/crypto_list/view/crypto_list_screen.dart';
import 'package:flutter_study_guide/features/crypto_list/view/trading_screen.dart';
import 'package:flutter_study_guide/features/crypto_list/view/userprofile_screen.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({super.key});

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  int _currentIndex = 0;
  
  final List<Widget> _children = [
    const CryptoListScreen(),
    const CryptoTradingScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
        ],
      ),
    );
  }
}