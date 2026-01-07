class PatientModel {
  final String id;
  final String fullName;
  final String dateOfBirth;
  final String bloodType;
  final String allergies;
  final String emergencyContact;
  final String emergencyPhone;
  final String medicalConditions;
  final String currentMedications;

  PatientModel({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.bloodType,
    required this.allergies,
    required this.emergencyContact,
    required this.emergencyPhone,
    required this.medicalConditions,
    required this.currentMedications,
  });

  // Convert Firebase Document to Object
  factory PatientModel.fromMap(Map<String, dynamic> data, String documentId) {
    return PatientModel(
      id: documentId,
      fullName: data['fullName'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? '',
      bloodType: data['bloodType'] ?? '',
      allergies: data['allergies'] ?? '',
      emergencyContact: data['emergencyContact'] ?? '',
      emergencyPhone: data['emergencyPhone'] ?? '',
      medicalConditions: data['medicalConditions'] ?? '',
      currentMedications: data['currentMedications'] ?? '',
    );
  }

  // Convert Object to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'bloodType': bloodType,
      'allergies': allergies,
      'emergencyContact': emergencyContact,
      'emergencyPhone': emergencyPhone,
      'medicalConditions': medicalConditions,
      'currentMedications': currentMedications,
    };
  }
}
