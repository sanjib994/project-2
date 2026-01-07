import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/medicine_model.dart';
import '../models/medicine_history.dart';
import '../models/alert.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Medicine (Caregiver Role)
  Future<void> addMedicine(MedicineModel medicine) {
    return _db.collection('medicines').add(medicine.toMap());
  }

  // Stream of Medicines for the Elder
  Stream<List<MedicineModel>> getMedicines() {
    return _db.collection('medicines').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => MedicineModel.fromMap(doc.data(), doc.id))
        .toList());
  }

  // Mark medicine as taken and add to history
  Future<void> updateMedicineStatus(String id, bool status) async {
    await _db.collection('medicines').doc(id).update({'isTaken': status});
    if (status) {
      // Get the medicine details
      DocumentSnapshot doc = await _db.collection('medicines').doc(id).get();
      MedicineModel medicine =
          MedicineModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      // Add to history
      MedicineHistory history = MedicineHistory(
        id: '', // Will be set by Firestore
        medicineId: id,
        name: medicine.name,
        dosage: medicine.dosage,
        scheduledDate:
            DateTime.now(), // Assuming today, but could be more precise
        scheduledTime: medicine.time,
        takenAt: DateTime.now(),
        isTaken: true,
      );
      await _db.collection('medicine_history').add(history.toMap());
    }
  }

  // Stream of Medicine History
  Stream<List<MedicineHistory>> getMedicineHistory() {
    return _db
        .collection('medicine_history')
        .orderBy('scheduledDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MedicineHistory.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Add Alert
  Future<void> addAlert(Alert alert) {
    return _db.collection('alerts').add(alert.toMap());
  }

  // Stream of Alerts
  Stream<List<Alert>> getAlerts() {
    return _db
        .collection('alerts')
        .orderBy('alertTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Alert.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Resolve Alert
  Future<void> resolveAlert(String id) {
    return _db.collection('alerts').doc(id).update({'isResolved': true});
  }
}
