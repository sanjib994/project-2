import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineHistory {
  final String id;
  final String medicineId;
  final String name;
  final String dosage;
  final DateTime scheduledDate;
  final String scheduledTime;
  final DateTime? takenAt;
  final bool isTaken; // true if taken, false if missed

  MedicineHistory({
    required this.id,
    required this.medicineId,
    required this.name,
    required this.dosage,
    required this.scheduledDate,
    required this.scheduledTime,
    this.takenAt,
    required this.isTaken,
  });

  // Convert Firebase Document to Object
  factory MedicineHistory.fromMap(
      Map<String, dynamic> data, String documentId) {
    return MedicineHistory(
      id: documentId,
      medicineId: data['medicineId'] ?? '',
      name: data['name'] ?? '',
      dosage: data['dosage'] ?? '',
      scheduledDate: (data['scheduledDate'] as Timestamp).toDate(),
      scheduledTime: data['scheduledTime'] ?? '',
      takenAt: data['takenAt'] != null
          ? (data['takenAt'] as Timestamp).toDate()
          : null,
      isTaken: data['isTaken'] ?? false,
    );
  }

  // Convert Object to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'medicineId': medicineId,
      'name': name,
      'dosage': dosage,
      'scheduledDate': Timestamp.fromDate(scheduledDate),
      'scheduledTime': scheduledTime,
      'takenAt': takenAt != null ? Timestamp.fromDate(takenAt!) : null,
      'isTaken': isTaken,
    };
  }
}
