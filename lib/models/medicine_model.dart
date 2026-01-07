class MedicineModel {
  final String id;
  final String name;
  final String dosage;
  final String time; // e.g., "08:00 AM"
  final List<String> days; // ["Monday", "Wednesday"]
  final bool isTaken;

  MedicineModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.days,
    this.isTaken = false,
  });

  // Convert Firebase Document to Object
  factory MedicineModel.fromMap(Map<String, dynamic> data, String documentId) {
    return MedicineModel(
      id: documentId,
      name: data['name'] ?? '',
      dosage: data['dosage'] ?? '',
      time: data['time'] ?? '',
      days: List<String>.from(data['days'] ?? []),
      isTaken: data['isTaken'] ?? false,
    );
  }

  // Convert Object to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'time': time,
      'days': days,
      'isTaken': isTaken,
    };
  }
}