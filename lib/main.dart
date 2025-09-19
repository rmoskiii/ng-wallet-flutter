import 'package:flutter/material.dart';
import 'features/auth/screens/signin_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/dashboard/screens/dashboard_screen.dart'; 
import 'features/dashboard/screens/goals_screen.dart';
import 'features/auth/screens/bvn_verification_screen.dart';
import 'shared/widgets/bottom_nav.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NG Wallet Flutter',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/dashboard': (context) => BottomNav(),        
        '/goals': (context) => const GoalsScreen(),
        '/bvn-verification': (context) => const BvnVerificationScreen(),       
      },
    );
  }
}
