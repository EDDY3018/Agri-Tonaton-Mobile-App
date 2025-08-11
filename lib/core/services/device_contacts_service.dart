import 'package:agri_tonaton/features%20/modules/contacts/model/buyer_model.dart';
import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:permission_handler/permission_handler.dart';


class DeviceContactsService {
  Future<List<Buyer>> fetchContacts() async {
    final status = await Permission.contacts.request();
    if (!status.isGranted) throw Exception('Contacts permission denied');

    final Iterable<Contact> contacts = await ContactsService.getContacts(
      withThumbnails: false,
      photoHighResolution: false,
      iOSLocalizedLabels: false,
    );

    return contacts
        .where((c) => (c.phones?.isNotEmpty ?? false))
        .map((c) {
          final phone = c.phones!.first.value?.trim() ?? '';
          final name  = (c.displayName ?? '').trim().isEmpty ? phone : c.displayName!.trim();
          final id    = (c.identifier ?? '${name}_$phone').trim();
          return Buyer(id: id, name: name, phone: phone);
        })
        .toList();
  }
}
