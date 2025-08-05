import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/core/utils/customContiner.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/navigator.dart';
import '../../../login_signup/login_signup.dart';

class PasswordResetSuccessPage extends StatelessWidget {
  const PasswordResetSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, size: 100, color: Colors.green),
                const SizedBox(height: 30),
                const Text(
                  "Successful",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Congratulations! Your password has been changed. Click continue to login",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  label: "Continue",
                  onPressed: () {
                    customNavigator(context, const LoginSignupPage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
