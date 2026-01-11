class MedicineModel {
  final String id;
  final String name;
  final String dosage;
  final String time; // e.g., "08:00 AM"
  final List<String> days; // ["Monday", "Wednesday"]
  final bool isTaken;
  final int? remainingDoses; // Optional: number of doses left
  final DateTime? refillDate; // Optional: date for refill reminder
  final String? notes; // Optional: additional notes

  MedicineModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.days,
    this.isTaken = false,
    this.remainingDoses,
    this.refillDate,
    this.notes,
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
      remainingDoses: data['remainingDoses'],
      refillDate: data['refillDate'] != null
          ? DateTime.parse(data['refillDate'])
          : null,
      notes: data['notes'],
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
      'remainingDoses': remainingDoses,
      'refillDate': refillDate?.toIso8601String(),
      'notes': notes,
    };
  }
}
