import 'package:agri_tonaton/features%20/modules/contacts/model/buyer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BuyerRepository {
  final _db = FirebaseFirestore.instance;

  // Path: users/{uid}/buyers
  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _db.collection('users').doc(uid).collection('buyers');

  Future<void> upsertSelectedBuyers({
    required String uid,
    required List<Buyer> buyers,
  }) async {
    final batch = _db.batch();
    for (final b in buyers) {
      final doc = _col(uid).doc(b.id);
      batch.set(doc, b.toMap(), SetOptions(merge: true));
    }
    await batch.commit();
  }

  Stream<List<Buyer>> streamBuyers(String uid) {
    return _col(uid).orderBy('name').snapshots().map(
      (snap) => snap.docs.map((d) => Buyer.fromMap(d.data())).toList(),
    );
  }
}
