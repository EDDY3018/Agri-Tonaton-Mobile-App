import 'package:agri_tonaton/core/models/user_model.dart';
import 'package:agri_tonaton/core/utils/bottom_nav_bar.dart';
import 'package:agri_tonaton/core/utils/customContiner.dart';
import 'package:agri_tonaton/core/utils/custom_text_field.dart';
import 'package:agri_tonaton/core/utils/navigator.dart';
import 'package:agri_tonaton/core/utils/password_textfeild.dart';
import 'package:agri_tonaton/features%20/auth/auth_view_model/auth_view_model.dart';
import 'package:agri_tonaton/features%20/auth/forgot_password/forgot.dart';
import 'package:flutter/material.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  bool isLogin = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers & Focus Nodes
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/health.png',
                  height: 90,
                ), // Replace with your logo
                const SizedBox(height: 30),

                // TOGGLE BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => isLogin = true),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isLogin ? PRIMARY : Colors.grey,
                            ),
                          ),
                          if (isLogin)
                            Container(
                              height: 3,
                              width: 100, // increased from 50
                              color: PRIMARY,
                              margin: const EdgeInsets.only(top: 6),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 150,
                    ), // increased spacing from 40 to 80
                    GestureDetector(
                      onTap: () => setState(() => isLogin = false),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: !isLogin ? PRIMARY : Colors.grey,
                            ),
                          ),
                          if (!isLogin)
                            Container(
                              height: 3,
                              width: 100, // increased from 50
                              color: PRIMARY,
                              margin: const EdgeInsets.only(top: 6),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ========== FORM FIELDS ==========
                if (!isLogin) ...[
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ), // optional: inner spacing
                    child: textFormField(
                      hintText: "Full Name",
                      controller: _nameController,
                      validateMsg: "Name is required",
                      focusNode: _nameFocus,
                      keyboardType: TextInputType.name,
                      inputFormatters: [],
                      labelStyle: const TextStyle(),
                      onTap: () {},
                    ),
                  ),

                  const SizedBox(height: 15),
                ],
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ), //
                  child: textFormField(
                    hintText: "Your Email",
                    controller: _emailController,
                    validateMsg: "Email is required",
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    validateEmail: true,
                    inputFormatters: [],
                    labelStyle: const TextStyle(),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 15),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ), //
                  child: PasswordField(
                    hintText: "Password",
                    controller: _passwordController,
                    validateMsg: "Password is required",
                    focusNode: _passwordFocus,
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 15),

                if (isLogin)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        customNavigator(context, ForgotPasswordPage());
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: PRIMARY, fontSize: 13),
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                CustomButton(
                  label: isLogin ? "Continue" : "Create Account",
                  onPressed: () async {
                    final auth = Provider.of<AuthViewModel>(
                      context,
                      listen: false,
                    );

                    if (_formKey.currentState!.validate()) {
                      if (isLogin) {
                        await auth.login(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      } else {
                        final user = UserModel(
  uid: '', // placeholder, will be set in ViewModel
  fullName: _nameController.text.trim(),
  email: _emailController.text.trim(),
);


                        await auth.signUp(
                          user,
                          _passwordController.text.trim(),
                        );
                      }

                      // Show error if any
                      if (auth.error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(auth.error!),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // Redirect to home (change 'HomePage()' to your actual homepage widget)
                        customNavigator(context, BTNAV(pageIndex: 0));
                      }
                    }
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 15),

                OutlinedButton.icon(
                  onPressed: () async {
                    final auth = Provider.of<AuthViewModel>(
                      context,
                      listen: false,
                    );
                    await auth.signInWithGoogle();

                    if (auth.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(auth.error!),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      customNavigator(context, BTNAV(pageIndex: 0));
                    }
                  },

                  icon: Image.asset('assets/G.png', scale: 10),
                  label: const Text(
                    "Login with Google",
                    style: TextStyle(color: BLACK),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin
                          ? "Don’t have an account? "
                          : "Already have an account? ",
                    ),
                    GestureDetector(
                      onTap: () => setState(() => isLogin = !isLogin),
                      child: Text(
                        isLogin ? "Sign up" : "Log in",
                        style: const TextStyle(color: PRIMARY),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
