import 'package:flutter/material.dart';
import 'package:ngwallet_flutter/features/dashboard/screens/dashboard_screen.dart';
import 'package:ngwallet_flutter/features/activity/screens/activity_screen.dart';
import 'package:ngwallet_flutter/features/wallet/screens/wallet_screen.dart';
import 'package:ngwallet_flutter/features/profile/screens/profile_screen.dart';
import 'package:ngwallet_flutter/features/learn/screens/learn_screen.dart';
import 'package:ngwallet_flutter/constants/menu_page.dart'; // 👈 import MenuPage

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    ActivityScreen(),
    WalletScreen(),
    UserProfilePage(),
    LearnScreen(),
  ];

  final List<String> _titles = const [
    "Dashboard",
    "Activity",
    "Wallet",
    "Profile",
    "Learn",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _titles[_currentIndex],
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        centerTitle: true, // 👈 keep it in the middle
      ),
      drawer: const MenuPage(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "Learn",
          ),
        ],
      ),
    );
  }
}
