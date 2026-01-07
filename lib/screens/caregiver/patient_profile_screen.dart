import 'package:flutter/material.dart';
import '../../models/patient_model.dart';
import '../../services/patient_database.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  late PatientModel patient;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _bloodTypeController;
  late TextEditingController _allergiesController;
  late TextEditingController _emergencyContactController;
  late TextEditingController _emergencyPhoneController;
  late TextEditingController _medicalConditionsController;
  late TextEditingController _currentMedicationsController;

  bool _isEditing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPatient();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _bloodTypeController.dispose();
    _allergiesController.dispose();
    _emergencyContactController.dispose();
    _emergencyPhoneController.dispose();
    _medicalConditionsController.dispose();
    _currentMedicationsController.dispose();
    super.dispose();
  }

  Future<void> _loadPatient() async {
    try {
      final loadedPatient = await PatientDatabase.initializeDefaultPatient();
      setState(() {
        patient = loadedPatient;
        _nameController = TextEditingController(text: patient.fullName);
        _dobController = TextEditingController(text: patient.dateOfBirth);
        _bloodTypeController = TextEditingController(text: patient.bloodType);
        _allergiesController = TextEditingController(text: patient.allergies);
        _emergencyContactController =
            TextEditingController(text: patient.emergencyContact);
        _emergencyPhoneController =
            TextEditingController(text: patient.emergencyPhone);
        _medicalConditionsController =
            TextEditingController(text: patient.medicalConditions);
        _currentMedicationsController =
            TextEditingController(text: patient.currentMedications);
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading patient: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      patient = PatientModel(
        id: patient.id,
        fullName: _nameController.text,
        dateOfBirth: _dobController.text,
        bloodType: _bloodTypeController.text,
        allergies: _allergiesController.text,
        emergencyContact: _emergencyContactController.text,
        emergencyPhone: _emergencyPhoneController.text,
        medicalConditions: _medicalConditionsController.text,
        currentMedications: _currentMedicationsController.text,
      );

      // Save to local database
      PatientDatabase.savePatient(patient).then((success) {
        if (success) {
          setState(() {
            _isEditing = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile saved successfully to local database'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error saving profile'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        elevation: 4,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isEditing ? Icons.close : Icons.edit,
                color: Colors.white,
                size: 22,
              ),
            ),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _isEditing ? _buildEditForm() : _buildViewMode(),
              ),
      ),
    );
  }

  Widget _buildViewMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard('Full Name', patient.fullName, Icons.person),
        _buildInfoCard('Date of Birth', patient.dateOfBirth, Icons.cake),
        _buildInfoCard(
            'Blood Type', patient.bloodType, Icons.bloodtype_outlined),
        _buildInfoCard('Allergies', patient.allergies, Icons.warning),
        _buildInfoCard('Medical Conditions', patient.medicalConditions,
            Icons.health_and_safety),
        _buildInfoCard('Current Medications', patient.currentMedications,
            Icons.medication),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 16),
        const Text('Emergency Contact',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildInfoCard(
            'Contact Name', patient.emergencyContact, Icons.contacts),
        _buildInfoCard('Phone Number', patient.emergencyPhone, Icons.phone),
      ],
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField('Full Name', _nameController),
          _buildTextField('Date of Birth (YYYY-MM-DD)', _dobController),
          _buildTextField('Blood Type', _bloodTypeController),
          _buildTextField('Allergies', _allergiesController),
          _buildTextField('Medical Conditions', _medicalConditionsController),
          _buildTextField('Current Medications', _currentMedicationsController),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          const Text('Emergency Contact',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildTextField(
              'Emergency Contact Name', _emergencyContactController),
          _buildTextField('Emergency Phone Number', _emergencyPhoneController),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.purple.shade600, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
