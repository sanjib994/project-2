import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/patient_model.dart';

class PatientDatabase {
  static const String _patientKey = 'patient_data';

  // Get patient data from local storage
  static Future<PatientModel?> getPatient() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_patientKey);

    if (jsonString == null) {
      return null;
    }

    try {
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return PatientModel.fromMap(jsonData, '1');
    } catch (e) {
      print('Error loading patient data: $e');
      return null;
    }
  }

  // Save patient data to local storage
  static Future<bool> savePatient(PatientModel patient) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final jsonString = jsonEncode(patient.toMap());
      return await prefs.setString(_patientKey, jsonString);
    } catch (e) {
      print('Error saving patient data: $e');
      return false;
    }
  }

  // Initialize with default patient data if none exists
  static Future<PatientModel> initializeDefaultPatient() async {
    final existingPatient = await getPatient();

    if (existingPatient != null) {
      return existingPatient;
    }

    // Create default patient
    final defaultPatient = PatientModel(
      id: '1',
      fullName: 'John Doe',
      dateOfBirth: '1950-05-15',
      bloodType: 'O+',
      allergies: 'Penicillin, Peanuts',
      emergencyContact: 'Jane Doe',
      emergencyPhone: '+1-234-567-8900',
      medicalConditions: 'Diabetes, Hypertension',
      currentMedications: 'Metformin, Lisinopril',
    );

    await savePatient(defaultPatient);
    return defaultPatient;
  }

  // Delete all patient data
  static Future<bool> deletePatient() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return await prefs.remove(_patientKey);
    } catch (e) {
      print('Error deleting patient data: $e');
      return false;
    }
  }

  // Clear all data
  static Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return await prefs.clear();
    } catch (e) {
      print('Error clearing all data: $e');
      return false;
    }
  }
}
