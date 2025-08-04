import 'package:flutter/material.dart';

customNavigator(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => page),
  );
}
