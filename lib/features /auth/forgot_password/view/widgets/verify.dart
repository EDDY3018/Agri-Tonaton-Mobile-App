import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/core/utils/customContiner.dart';
import 'package:agri_tonaton/core/utils/navigator.dart';
import 'package:agri_tonaton/features%20/auth/forgot_password/forgot.dart';
import 'package:agri_tonaton/features%20/auth/forgot_password/view/widgets/set_password.dart';
import 'package:flutter/material.dart';

class VerifyCodePage extends StatelessWidget {
  final String email;
  const VerifyCodePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              GestureDetector(
                onTap: () {
                  customNavigator(context, ForgotPasswordPage());
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                "Check your email",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "We sent a reset link to $email\nEnter the 5-digit code mentioned in the email",
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // 5-digit code fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),

              CustomButton(
                label: "Verify Code",
                onPressed: () {
                  customNavigator(context, SetPasswordPage(email: email));
                },
              ),

              const SizedBox(height: 20),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Resend email"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
