import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service_plus/contacts_service_plus.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact> _contacts = [];
  final Set<Contact> _selectedContacts = {};

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    if (await Permission.contacts.request().isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts
            .where((c) => c.phones != null && c.phones!.isNotEmpty)
            .toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied to access contacts')),
      );
    }
  }

  void _toggleSelect(Contact contact) {
    setState(() {
      if (_selectedContacts.contains(contact)) {
        _selectedContacts.remove(contact);
      } else {
        _selectedContacts.add(contact);
      }
    });
  }

  Future<void> _storeSelectedContacts() async {
    final batch = FirebaseFirestore.instance.batch();
    final contactsRef = FirebaseFirestore.instance.collection('buyers');

    for (var contact in _selectedContacts) {
      final doc = contactsRef.doc();
      batch.set(doc, {
        'name': contact.displayName ?? 'Unknown',
        'phone': contact.phones!.isNotEmpty ? contact.phones!.first.value : '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contacts saved to Firestore')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Buyers')),
      body: _contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (_, index) {
                final contact = _contacts[index];
                final isSelected = _selectedContacts.contains(contact);
                final phone = contact.phones?.isNotEmpty == true
                    ? contact.phones!.first.value!
                    : '';

                return ListTile(
                  leading: Checkbox(
                    value: isSelected,
                    onChanged: (_) => _toggleSelect(contact),
                  ),
                  title: Text(contact.displayName ?? 'No Name'),
                  subtitle: Text(phone),
                  trailing: const Icon(Icons.call, color: Colors.green),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _storeSelectedContacts,
        label: const Text("Save to Firestore"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
