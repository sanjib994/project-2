import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/medicine_model.dart';

class MedicineDatabase {
  static const String _medicinesKey = 'medicines_list';
  static const int maxMedicines = 5;

  // Get all medicines from local storage
  static Future<List<MedicineModel>> getAllMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_medicinesKey);

    if (jsonString == null) {
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((item) => MedicineModel.fromMap(
              item as Map<String, dynamic>, item['id'] as String))
          .toList();
    } catch (e) {
      print('Error loading medicines: $e');
      return [];
    }
  }

  // Get a single medicine by ID
  static Future<MedicineModel?> getMedicineById(String id) async {
    final medicines = await getAllMedicines();
    try {
      return medicines.firstWhere((med) => med.id == id);
    } catch (e) {
      return null;
    }
  }

  // Add a new medicine (max 5)
  static Future<bool> addMedicine(MedicineModel medicine) async {
    try {
      final medicines = await getAllMedicines();

      if (medicines.length >= maxMedicines) {
        print('Maximum $maxMedicines medicines reached');
        return false;
      }

      medicines.add(medicine);
      return await _saveMedicines(medicines);
    } catch (e) {
      print('Error adding medicine: $e');
      return false;
    }
  }

  // Update an existing medicine
  static Future<bool> updateMedicine(MedicineModel medicine) async {
    try {
      final medicines = await getAllMedicines();
      final index = medicines.indexWhere((med) => med.id == medicine.id);

      if (index == -1) {
        print('Medicine not found');
        return false;
      }

      medicines[index] = medicine;
      return await _saveMedicines(medicines);
    } catch (e) {
      print('Error updating medicine: $e');
      return false;
    }
  }

  // Delete a medicine by ID
  static Future<bool> deleteMedicine(String id) async {
    try {
      final medicines = await getAllMedicines();
      medicines.removeWhere((med) => med.id == id);
      return await _saveMedicines(medicines);
    } catch (e) {
      print('Error deleting medicine: $e');
      return false;
    }
  }

  // Save all medicines to local storage
  static Future<bool> _saveMedicines(List<MedicineModel> medicines) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final jsonList = medicines
          .map((medicine) => {
                ...medicine.toMap(),
                'id': medicine.id,
              })
          .toList();
      final jsonString = jsonEncode(jsonList);
      return await prefs.setString(_medicinesKey, jsonString);
    } catch (e) {
      print('Error saving medicines: $e');
      return false;
    }
  }

  // Get count of medicines
  static Future<int> getMedicineCount() async {
    final medicines = await getAllMedicines();
    return medicines.length;
  }

  // Check if maximum medicines reached
  static Future<bool> isMaxMedicinesReached() async {
    final count = await getMedicineCount();
    return count >= maxMedicines;
  }

  // Clear all medicines
  static Future<bool> clearAllMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return await prefs.remove(_medicinesKey);
    } catch (e) {
      print('Error clearing medicines: $e');
      return false;
    }
  }

  // Initialize with sample medicines if empty
  static Future<void> initializeDefaultMedicines() async {
    final medicines = await getAllMedicines();
    if (medicines.isEmpty) {
      final defaultMedicines = [
        MedicineModel(
          id: '1',
          name: 'Aspirin',
          dosage: '500mg',
          time: '08:00 AM',
          days: ['Monday', 'Wednesday', 'Friday'],
          isTaken: false,
        ),
        MedicineModel(
          id: '2',
          name: 'Vitamin D',
          dosage: '1000IU',
          time: '09:00 AM',
          days: ['Daily'],
          isTaken: false,
        ),
      ];

      for (var medicine in defaultMedicines) {
        await addMedicine(medicine);
      }
    }
  }
}
