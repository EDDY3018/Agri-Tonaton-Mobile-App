import 'package:agri_tonaton/core/repositories/user_repository.dart';
import 'package:agri_tonaton/core/services/auth_service.dart';
import 'package:agri_tonaton/core/utils/app.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/features%20/auth/auth_view_model/auth_view_model.dart';
import 'package:agri_tonaton/features%20/modules/contacts/view_model/contacts_vm.dart';
import 'package:agri_tonaton/features%20/modules/products/view_model/product_viewmodel.dart';

import 'package:agri_tonaton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/repositories/buyer_repository.dart';
import 'core/services/device_contacts_service.dart';
import 'core/utils/local_storage_service.dart';
import 'features /modules/profile/view_model/profile_vm.dart'; // adjust to your splash screen path

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(AuthService(), UserRepository()),
        ),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),

        ChangeNotifierProxyProvider<AuthViewModel, ContactsViewModel>(
          create: (_) => ContactsViewModel(
            contactsService: DeviceContactsService(),
            repo: BuyerRepository(),
            uid: '', // start empty
          )..init(),
          update: (_, auth, vm) {
            vm ??= ContactsViewModel(
              contactsService: DeviceContactsService(),
              repo: BuyerRepository(),
              uid: '',
            )..init();

            // safely inject uid from Auth
            vm.setUid(auth.currentUser?.uid);

            return vm;
          },
        ),
         ChangeNotifierProvider(
      create: (_) => ProfileViewModel(LocalStorageService())..init(),
    ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agri Tonaton',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: PRIMARY)),
      home: Splash(), // ensure this widget exists
    );
  }
}
