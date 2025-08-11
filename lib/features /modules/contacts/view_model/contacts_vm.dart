
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:agri_tonaton/core/repositories/buyer_repository.dart';
import 'package:agri_tonaton/core/services/device_contacts_service.dart';
import 'package:agri_tonaton/features%20/modules/contacts/model/buyer_model.dart';

class ContactsViewModel extends ChangeNotifier {
  final DeviceContactsService contactsService;
  final BuyerRepository repo;
  String uid = '';
String get _uid => uid;
void setUid(String? value) {
  if (value != null && value.isNotEmpty) {
    uid = value;
  }
}
 // from FirebaseAuth

  ContactsViewModel({
    required this.contactsService,
    required this.repo,
    required this.uid,
  });

  // --- UI state ---
  final TextEditingController searchCtl = TextEditingController();
  bool loading = false;
  String? error;
  String dropdown = 'Contacts';

  // --- Data ---
  final List<Buyer> _all = [];
  String _filter = '';
  StreamSubscription<List<Buyer>>? _savedSub;
  bool _initialized = false;

  // ---------- Getters ----------
  List<Buyer> get list {
    final q = _filter.toLowerCase().trim();
    if (q.isEmpty) return _all;
    return _all.where((b) =>
        b.name.toLowerCase().contains(q) || b.phone.contains(q)).toList();
  }

  List<Buyer> get selected => _all.where((b) => b.selected).toList();

  bool get hasSelection => _all.any((b) => b.selected);

  // ---------- Lifecycle ----------
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    loading = true;
    error = null;
    notifyListeners();

    try {
      // 1) Load device contacts once
      final deviceContacts = await contactsService.fetchContacts();

      // Sort by name to stabilize UI
      deviceContacts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      _all
        ..clear()
        ..addAll(deviceContacts);

      // 2) Listen to saved buyers to keep selection in sync
      _savedSub = repo.streamBuyers(_uid).listen((saved) {
        _applySavedSelections(saved);
        notifyListeners();
      });
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _savedSub?.cancel();
    searchCtl.dispose();
    super.dispose();
  }

  // ---------- Intents / Commands ----------
  void onSearch(String v) {
    _filter = v;
    notifyListeners();
  }

  void setDropdown(String v) {
    if (dropdown == v) return;
    dropdown = v;
    notifyListeners();
  }

  void toggle(String id, bool value) {
    final idx = _all.indexWhere((b) => b.id == id);
    if (idx == -1) return;
    _all[idx] = _all[idx].copyWith(selected: value);
    notifyListeners();
  }

  void selectAllVisible(bool value) {
    for (final b in list) {
      final idx = _all.indexWhere((x) => x.id == b.id);
      if (idx != -1) _all[idx] = _all[idx].copyWith(selected: value);
    }
    notifyListeners();
  }

  Future<void> persistSelection() async {
    // writes only the currently selected buyers
    await repo.upsertSelectedBuyers(uid: _uid, buyers: selected);
  }

  Future<void> refreshContacts() async {
    loading = true; notifyListeners();
    try {
      final deviceContacts = await contactsService.fetchContacts();
      deviceContacts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      // keep current selections by id
      final selectedIds = _all.where((b) => b.selected).map((b) => b.id).toSet();

      _all
        ..clear()
        ..addAll(deviceContacts.map((b) =>
            b.copyWith(selected: selectedIds.contains(b.id))));
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false; notifyListeners();
    }
  }

  // ---------- Helpers ----------
  void _applySavedSelections(List<Buyer> savedFromFirestore) {
    // We only care about marking device contacts as selected
    final savedIds = savedFromFirestore
        .where((b) => b.selected)
        .map((b) => b.id)
        .toSet();

    for (var i = 0; i < _all.length; i++) {
      final b = _all[i];
      final shouldBeSelected = savedIds.contains(b.id);
      if (b.selected != shouldBeSelected) {
        _all[i] = b.copyWith(selected: shouldBeSelected);
      }
    }
  }
}
