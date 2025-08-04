
import 'package:agri_tonaton/core/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class UserRepository extends ChangeNotifier {
  final _db = FirebaseDatabase.instance.ref();

  Future<void> createUser(UserModel user) async {
    await _db.child('users').child(user.email).set(user.toJson());
  }

  Future<UserModel?> getUser(String email) async {
    final snapshot = await _db.child('users').child(email).get();
    if (snapshot.exists) {
      return UserModel.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    return null;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final snapshot = await _db.child('users').get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      final match = data.values.firstWhere(
        (e) => e['email'] == email,
        orElse: () => null,
      );
      if (match != null) {
        return UserModel.fromJson(Map<String, dynamic>.from(match));
      }
    }
    return null;
  }


  Future<List<UserModel>?> getAllUsers() async {
  final snapshot = await _db.child('users').get();
  if (snapshot.exists) {
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return data.values
        .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
  return [];
}

}
