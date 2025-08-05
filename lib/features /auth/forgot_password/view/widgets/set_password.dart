import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/core/utils/customContiner.dart';
import 'package:agri_tonaton/core/utils/custom_text_field.dart';
import 'package:agri_tonaton/core/utils/navigator.dart';
import 'package:agri_tonaton/features%20/auth/forgot_password/forgot.dart';
import 'package:agri_tonaton/features%20/auth/forgot_password/view/widgets/succesful.dart';
import 'package:flutter/material.dart';

class SetPasswordPage extends StatefulWidget {
  final String email;
  const SetPasswordPage({super.key, required this.email});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

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
              // Back
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
                "Set a new password",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Create a new password. Ensure it differs from previous ones for security",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ), // grey border
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // optional: rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: textFormField(
                  hintText: "Password",
                  controller: _passwordController,
                  validateMsg: "Password is required",
                  focusNode: FocusNode(),
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [],
                  labelStyle: const TextStyle(),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ), // grey border
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // optional: rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: textFormField(
                  hintText: "Confirm Password",
                  controller: _confirmController,
                  validateMsg: "Confirm Password is required",
                  focusNode: FocusNode(),
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [],
                  labelStyle: const TextStyle(),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 30),

              CustomButton(
                label: "Continue",
                onPressed: () {
                  // Just simulate the success
                  customNavigator(context, PasswordResetSuccessPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
