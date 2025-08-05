import 'package:agri_tonaton/core/utils/customContiner.dart';
import 'package:agri_tonaton/core/utils/custom_text_field.dart';
import 'package:agri_tonaton/core/utils/navigator.dart';
import 'package:agri_tonaton/features%20/auth/auth_view_model/auth_view_model.dart';
import 'package:agri_tonaton/features%20/auth/forgot_password/view/widgets/verify.dart';
import 'package:agri_tonaton/features%20/auth/login_signup/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/toast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  void _resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      Toast.show(
        context,
        text: "Please enter your email",
        color: Colors.orange,
      );
      return;
    }

    try {
      final auth = Provider.of<AuthViewModel>(context, listen: false);
      await auth.resetPassword(email);

      Toast.show(
        context,
        text: "Reset link sent to your email.",
        color: Colors.green,
      );

      customNavigator(context, VerifyCodePage(email: email));
    } catch (e) {
      final auth = Provider.of<AuthViewModel>(context, listen: false);
      Toast.show(
        context,
        text: "Error: ${auth.error ?? 'Failed to send reset link'}",
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              GestureDetector(
                onTap: () {
                  customNavigator(context, LoginSignupPage());
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

              // Title
              const Text(
                "Forgot password",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Subtitle
              const Text(
                "Please enter your email to reset the password",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(161, 74, 88, 123),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Your Email",
                style: TextStyle(fontSize: 14, color: BLACK),
              ),
              // Email Field
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
                  hintText: "Your Email",
                  controller: _emailController,
                  validateMsg: "Email is required",
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [],
                  labelStyle: const TextStyle(),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 30),

              // Reset Button
              CustomButton(label: "Reset", onPressed: _resetPassword),
            ],
          ),
        ),
      ),
    );
  }
}
