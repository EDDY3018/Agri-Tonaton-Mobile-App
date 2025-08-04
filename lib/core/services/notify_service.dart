// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:library_seat_booking/features/notification/view/notify.dart';
// import 'package:library_seat_booking/main.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// class NotificationService {
//   static const String _cacheKey = 'cached_notifications';
//   static final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();

//   /// Initialize local notifications
//   static Future<void> initialize() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('seat_icon');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await _localNotifications.initialize(initializationSettings);
//   }

//   /// Setup listeners for FCM background and foreground messages
//   static void setupFCMListeners(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       if (notification != null) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'high_importance_channel',
//               'High Importance Notifications',
//               importance: Importance.high,
//               priority: Priority.high,
//             ),
//           ),
//         );
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       navigatorKey.currentState?.push(
//         MaterialPageRoute(builder: (_) => const NotificationScreen()),
//       );
//     });
//   }

//   /// Show a local notification (used as fallback)
//   static Future<void> showLocalNotification({
//     required String title,
//     required String body,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//           'high_importance_channel',
//           'High Importance Notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker',
//         );

//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       title,
//       body,
//       notificationDetails,
//     );
//   }

//   /// Save notification to Firestore under notifications collection
//   static Future<void> saveNotificationToFirestore({
//     required String userId,
//     required String title,
//     required String body,
//   }) async {
//     try {
//       await FirebaseFirestore.instance.collection('notifications').add({
//         'userId': userId,
//         'title': title,
//         'body': body,
//         'timestamp':
//             FieldValue.serverTimestamp(), // 🔥 safer than DateTime.now()
//       });
//     } catch (e) {
//       print('🔥 Error saving notification to Firestore: $e');
//     }
//   }

//   /// Save notifications locally to cache
//   static Future<void> cacheNotifications(
//     List<Map<String, dynamic>> notifications,
//   ) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_cacheKey, jsonEncode(notifications));
//   }

//   /// Get cached notifications
//   static Future<List<Map<String, dynamic>>> getCachedNotifications() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString(_cacheKey);
//     if (jsonString == null) return [];
//     return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
//   }

//   /// Clear cached notifications
//   static Future<void> clearCache() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_cacheKey);
//   }

  
// }
