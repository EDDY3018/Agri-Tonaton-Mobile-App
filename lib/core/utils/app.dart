// ignore_for_file: prefer_const_constructors

import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/core/utils/bottom_nav_bar.dart';
import 'package:agri_tonaton/core/utils/local_storage_service.dart';
import 'package:agri_tonaton/core/utils/navigator.dart';
import 'package:agri_tonaton/features%20/auth/login_signup/login_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalStorageService _localStorage = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // Splash delay

    final localUser = await _localStorage.getUser();
    final firebaseUser = _auth.currentUser;

    if (firebaseUser != null && localUser != null) {
      // Both Firebase and local user exist → auto-login
      customNavigator(context, BTNAV(pageIndex: 0));
    } else {
      // Not logged in or incomplete
      customNavigator(context, const LoginSignupPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          scale: 4,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        ),
      ),
    );
  }
}
