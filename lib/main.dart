import 'package:agri_tonaton/core/repositories/user_repository.dart';
import 'package:agri_tonaton/core/services/auth_service.dart';
import 'package:agri_tonaton/core/utils/app.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/core/utils/internet_checker.dart';
import 'package:agri_tonaton/features%20/auth/auth_view_model/auth_view_model.dart';
import 'package:agri_tonaton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(AuthService(), UserRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agri Tonaton',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: PRIMARY)),
      home: Splash(),
    );
  }
}
