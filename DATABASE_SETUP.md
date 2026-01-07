"""
LOCAL STATIC DATABASE SETUP - DOCUMENTATION
=============================================

This is a simple local database system using SharedPreferences for storing patient data locally.

ARCHITECTURE:
=============

1. PatientModel (lib/models/patient_model.dart)
   - Defines patient data structure
   - Has fromMap() and toMap() methods for JSON conversion
   - Fixed fields: fullName, dateOfBirth, bloodType, allergies, 
     emergencyContact, emergencyPhone, medicalConditions, currentMedications

2. PatientDatabase Service (lib/services/patient_database.dart)
   - Handles all database operations
   - Uses SharedPreferences for local storage
   - Key methods:
     * getPatient() - Retrieve patient data
     * savePatient() - Save/update patient data
     * initializeDefaultPatient() - Load or create default patient
     * deletePatient() - Remove patient data
     * clearAll() - Clear all stored data

3. PatientProfileScreen (lib/screens/caregiver/patient_profile_screen.dart)
   - UI for viewing and editing patient data
   - Automatically loads from local database on startup
   - Saves changes to database when user clicks "Save Changes"
   - Shows loading indicator while fetching data

DATA FLOW:
==========

View Mode:
┌─────────────────┐
│ Load Patient    │
│ from Database   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Display Cards   │
│ (Read-only)     │
└─────────────────┘

Edit Mode:
┌─────────────────┐
│ User Clicks     │
│ Edit Button     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Show Form       │
│ with TextFields │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ User Fills Form │
│ & Clicks Save   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Save to         │
│ SharedPrefs     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Show Success    │
│ Message         │
└─────────────────┘

STORAGE DETAILS:
================

Location: Device local storage
Type: SharedPreferences (Key-Value store)
Key Used: 'patient_data'
Format: JSON (serialized PatientModel)
Persistence: Survives app restarts
Size: Very small (single patient record)

USAGE EXAMPLES:
===============

// Load patient from database
PatientModel patient = await PatientDatabase.getPatient();

// Save patient to database
bool success = await PatientDatabase.savePatient(patientModel);

// Initialize with defaults if not exists
PatientModel patient = await PatientDatabase.initializeDefaultPatient();

// Delete patient data
bool success = await PatientDatabase.deletePatient();

// Clear all app data
bool success = await PatientDatabase.clearAll();

FEATURES:
=========

✓ Local storage - No internet required
✓ Persistent - Data survives app restart
✓ Simple - Easy to understand and modify
✓ Fixed structure - One patient with fixed fields
✓ Editable - Users can update information anytime
✓ Error handling - Try-catch blocks for safety
✓ Validation - Form validation before saving

TO MODIFY THE FIELDS:
====================

1. Update PatientModel in lib/models/patient_model.dart
   - Add new fields to constructor
   - Update fromMap() and toMap() methods

2. Update PatientProfileScreen
   - Add new TextEditingController
   - Add new TextField in edit form
   - Add new info card in view mode

3. Update PatientDatabase service
   - Default patient initialization will use new fields

EXAMPLE OF ADDING A NEW FIELD:

In PatientModel:
  final String phoneNumber;  // Add new field
  
  PatientModel({
    ...existing fields...,
    required this.phoneNumber,  // Add to constructor
  });
  
  factory PatientModel.fromMap(Map<String, dynamic> data, String documentId) {
    return PatientModel(
      ...existing fields...,
      phoneNumber: data['phoneNumber'] ?? '',  // Add to fromMap
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      ...existing fields...,
      'phoneNumber': phoneNumber,  // Add to toMap
    };
  }

In PatientProfileScreen:
  late TextEditingController _phoneController;  // Add controller
  
  Future<void> _loadPatient() async {
    _phoneController = TextEditingController(text: patient.phoneNumber);
  }
  
  _buildTextField('Phone Number', _phoneController)  // Add in form

That's it! The database will automatically save and load the new field.
"""
