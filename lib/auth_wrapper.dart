import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AuthProvider.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    return user != null ? HomeScreen() : LoginScreen();
  }
}
