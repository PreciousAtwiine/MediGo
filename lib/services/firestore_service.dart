import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pharmacy.dart';
import '../models/medicine.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Pharmacy>> streamPharmacies() {
    return _db.collection('pharmacies').snapshots().map((snap) => snap.docs
        .map((doc) => Pharmacy.fromMap(doc.id, doc.data()))
        .toList());
  }

  Stream<List<Medicine>> streamMedicines({String? pharmacyId}) {
    Query query = _db.collection('medicine');
    if (pharmacyId != null) {
      query = query.where('pharmacyId', isEqualTo: pharmacyId);
    }
    return query.snapshots().map((snap) => snap.docs
        .map((doc) =>
            Medicine.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList());
  }
}