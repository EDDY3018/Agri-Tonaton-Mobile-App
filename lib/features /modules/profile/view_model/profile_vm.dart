// features/modules/profile/viewmodel/profile_viewmodel.dart
import 'dart:io';
import 'package:agri_tonaton/core/utils/local_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:agri_tonaton/core/models/user_model.dart';

import '../../profile/model/inbound_order.dart';

class ProfileViewModel extends ChangeNotifier {
  final LocalStorageService _storage;
  ProfileViewModel(this._storage);

  UserModel? _user;
  UserModel? get user => _user;

  bool _loading = true;
  bool get loading => _loading;

  // --- new: image selection state ---
  File? _pickedImageFile;
  File? get pickedImageFile => _pickedImageFile;

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  final _storageRef = FirebaseStorage.instance.ref();

  // orders (same as before)
  List<InboundOrder> _orders = const [];
  List<InboundOrder> get orders => _orders;
  int get totalOrders => _orders.length;
  int get pendingOrders =>
      _orders.where((o) => o.status == InboundOrderStatus.pending).length;

  Future<void> init() async {
    _loading = true;
    notifyListeners();

    _user = await _storage.getUser();

    // seed orders (unchanged)...
    _orders = [
      InboundOrder(
        id: "90897",
        requestedOn: DateTime(2021, 10, 19),
        itemsCount: 10,
        amountText: "Ghc160",
        status: InboundOrderStatus.newOrder,
      ),
      InboundOrder(
        id: "90897",
        requestedOn: DateTime(2021, 10, 19),
        itemsCount: 10,
        amountText: "Ghc160",
        status: InboundOrderStatus.pending,
      ),
      InboundOrder(
        id: "90897",
        requestedOn: DateTime(2021, 10, 19),
        itemsCount: 10,
        amountText: "Ghc160",
        status: InboundOrderStatus.finished,
      ),
    ];

    _loading = false;
    notifyListeners();
  }

  // --- new: pick image ---
  final _picker = ImagePicker();
  Future<void> pickProfileImage() async {
    final x = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (x != null) {
      _pickedImageFile = File(x.path);
      notifyListeners();
    }
  }

  void clearPickedImage() {
    _pickedImageFile = null;
    notifyListeners();
  }

  // --- new: save profile (location + photo) to Realtime Database ---
  Future<void> saveProfile({required String location}) async {
    if (_user == null) return;
    final uid = _user!.uid;

    // 1) If image picked, upload to Storage and grab URL
    String? photoUrl = _user!.photoUrl;
    if (_pickedImageFile != null) {
      final path = 'users/$uid/profile.jpg';
      final task = await _storageRef.child(path).putFile(_pickedImageFile!);
      photoUrl = await task.ref.getDownloadURL();
    }

    // 2) Update Realtime Database
    final updateData = {
      'fullName': _user!.fullName,
      'email': _user!.email,
      'photoUrl': photoUrl,
      'location': location,
    };
    await _db.child('users').child(uid).update(updateData);

    // 3) Update local user + SharedPreferences
    _user = _user!.copyWith(photoUrl: photoUrl, location: location, uid: '');
    await _storage.saveUser(_user!);

    // 4) Clear temp image
    _pickedImageFile = null;

    notifyListeners();
  }

  // logout unchanged
  Future<void> logout() async {
    await _storage.clearUser();
    _user = null;
    notifyListeners();
  }

  List<InboundOrder> byStatus(InboundOrderStatus s) =>
      _orders.where((o) => o.status == s).toList();
}
