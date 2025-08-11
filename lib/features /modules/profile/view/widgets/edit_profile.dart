// features/modules/profile/view/edit_profile_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/profile_vm.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _locationCtrl;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final vm = context.read<ProfileViewModel>();
    _locationCtrl = TextEditingController(text: vm.user?.location ?? '');
  }

  @override
  void dispose() {
    _locationCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final vm = context.read<ProfileViewModel>();
    await vm.saveProfile(location: _locationCtrl.text.trim());

    if (mounted) {
      setState(() => _saving = false);
      Navigator.pop(context); // back to profile
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();
    final themeGreen = const Color(0xFF0B8A2A);

    Widget avatar() {
      final file = vm.pickedImageFile;
      final url = vm.user?.photoUrl;

      ImageProvider? provider;
      if (file != null) {
        provider = FileImage(file);
      } else if (url != null && url.isNotEmpty) {
        provider = NetworkImage(url);
      }

      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 56,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 52,
              backgroundImage: provider,
              child: provider == null
                  ? const Icon(Icons.person, size: 48, color: Colors.black38)
                  : null,
            ),
          ),
          FloatingActionButton.small(
            heroTag: 'pick',
            onPressed: vm.pickProfileImage,
            backgroundColor: themeGreen,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          children: [
            Center(child: avatar()),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _locationCtrl,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'e.g., Karur, Tamilnadu',
                  filled: true,
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Location is required' : null,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
