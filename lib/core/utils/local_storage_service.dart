// import 'dart:convert';
// import 'package:flutter/material.dart';

// class LocalStorageService {
//   static const String userKey = 'loggedInUser';

//   Future<void> saveUser(UserModel user) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(userKey, jsonEncode(user.toJson()));
//   }

//   Future<UserModel?> getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = prefs.getString(userKey);
//     print("Retrieved user JSON: $userJson"); // Check what's stored
//     if (userJson == null) return null;
//     final user = UserModel.fromJson(jsonDecode(userJson));
//     print("Parsed user: ${user.fullName}, ${user.studentId}"); // Verify fields
//     return user;
//   }

//   Future<void> clearUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(userKey);
//   }

//   Future<String?> getUserName() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString(LocalStorageService.userKey);
//     if (jsonString == null) return null;

//     final data = jsonDecode(jsonString);
//     return data['fullName'] as String?;
//   }

//   Future<void> saveReservationTimes(DateTime date, TimeOfDay start, TimeOfDay end) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString('selectedDate', date.toIso8601String());
//   prefs.setString('startTime', '${start.hour}:${start.minute}');
//   prefs.setString('endTime', '${end.hour}:${end.minute}');
// }

// Future<Map<String, dynamic>?> getSavedReservationTimes() async {
//   final prefs = await SharedPreferences.getInstance();
//   final dateStr = prefs.getString('selectedDate');
//   final startStr = prefs.getString('startTime');
//   final endStr = prefs.getString('endTime');

//   if (dateStr != null && startStr != null && endStr != null) {
//     final date = DateTime.parse(dateStr);
//     final startParts = startStr.split(':');
//     final endParts = endStr.split(':');
//     final start = TimeOfDay(hour: int.parse(startParts[0]), minute: int.parse(startParts[1]));
//     final end = TimeOfDay(hour: int.parse(endParts[0]), minute: int.parse(endParts[1]));

//     return {'date': date, 'start': start, 'end': end};
//   }
//   return null;
// }

// }
