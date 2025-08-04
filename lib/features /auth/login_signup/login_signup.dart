// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/core/utils/navigator.dart';
import 'package:agri_tonaton/core/utils/textStyles.dart';
import 'package:flutter/material.dart';



class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool isLogin = true;

  void toggleView() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Toggle buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: w,
                height: 55,
                decoration: BoxDecoration(
                  color: PRIMARY,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = true;
                        });
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: isLogin ? Colors.white : Colors.grey[400],
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    VerticalDivider(
                        thickness: 1,
                        endIndent: 10,
                        indent: 10,
                        color: const Color.fromARGB(255, 221, 120, 120)),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = false;
                        });
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: !isLogin ? Colors.white : Colors.grey[400],
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80),

            // Form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: hint,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            if (!isLogin) ...[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: hint,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  hintStyle: hint,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            if (isLogin) ...[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: FORGOT,
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 10),
            if (!isLogin) ...[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 20),

            // Login/Register Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  // customNavigator(
                  //     context,
                  //     BTNAV(
                  //       pageIndex: 0,
                  //     ));
                },
                child: Container(
                  width: w,
                  height: 55,
                  decoration: BoxDecoration(
                    color: PRIMARY,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text(
                      isLogin ? 'Login' : 'Register',
                      style: CONTAINEERTEXT,
                    ),
                  ),
                ),
              ),
            ),

            // Social Media Login
            SizedBox(height: 20),
            Text('OR', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 5, 94, 210),
                    ),
                    child: Image.asset('assets/f.png')),
                SizedBox(width: 20),
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: WHITE,
                    ),
                    child: Image.asset('assets/goo.png')),
              ],
            ),
            SizedBox(height: 20),

            // Footer
            isLogin
                ? GestureDetector(
                    onTap: toggleView,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: BLACK,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                            text: 'Don’t have an account?',
                            style: TextStyle(
                              color: BLACK,
                            ),
                          ),
                          TextSpan(
                            text: ' Register',
                            style: TextStyle(
                              color: PRIMARY,
                            ),
                          ),
                        ],
                      ),
                    ))
                : GestureDetector(
                    onTap: toggleView,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: BLACK,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                              color: BLACK,
                            ),
                          ),
                          TextSpan(
                            text: ' Login',
                            style: TextStyle(
                              color: PRIMARY,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
