import 'package:cloud_firestore/cloud_firestore.dart';

class Alert {
  final String id;
  final String medicineId;
  final String medicineName;
  final String dosage;
  final DateTime scheduledDate;
  final String scheduledTime;
  final DateTime alertTime;
  final bool isResolved;

  Alert({
    required this.id,
    required this.medicineId,
    required this.medicineName,
    required this.dosage,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.alertTime,
    this.isResolved = false,
  });

  // Convert Firebase Document to Object
  factory Alert.fromMap(Map<String, dynamic> data, String documentId) {
    return Alert(
      id: documentId,
      medicineId: data['medicineId'] ?? '',
      medicineName: data['medicineName'] ?? '',
      dosage: data['dosage'] ?? '',
      scheduledDate: (data['scheduledDate'] as Timestamp).toDate(),
      scheduledTime: data['scheduledTime'] ?? '',
      alertTime: (data['alertTime'] as Timestamp).toDate(),
      isResolved: data['isResolved'] ?? false,
    );
  }

  // Convert Object to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'medicineId': medicineId,
      'medicineName': medicineName,
      'dosage': dosage,
      'scheduledDate': Timestamp.fromDate(scheduledDate),
      'scheduledTime': scheduledTime,
      'alertTime': Timestamp.fromDate(alertTime),
      'isResolved': isResolved,
    };
  }
}
