// ignore_for_file: prefer_const_constructors

import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/core/utils/bottom_nav_bar.dart';
import 'package:agri_tonaton/core/utils/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _checkUserLoggedIn() async {
    User? user = _auth.currentUser;
    if (user != null) {
      customNavigator(context, BTNAV(pageIndex: 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(),
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),
        ],
      ),
    );
  }
}
