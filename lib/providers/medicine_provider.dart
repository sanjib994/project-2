import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medicine_model.dart';
import '../models/alert.dart';
import '../services/firestore_service.dart';

class MedicineProvider with ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  List<MedicineModel> _medicines = [];

  List<MedicineModel> get medicines => _medicines;

  void fetchMedicines() {
    _service.getMedicines().listen((newList) {
      _medicines = newList;
      notifyListeners(); // This tells the UI to refresh
    });
  }

  // Check for missed doses and generate alerts
  Future<void> checkForMissedDoses() async {
    final now = DateTime.now();
    final today = DateFormat('EEEE').format(now);

    for (var medicine in _medicines) {
      if (medicine.days.contains(today) && !medicine.isTaken) {
        // Parse the time
        final timeParts = medicine.time.split(' ');
        final timeStr = timeParts[0];
        final period = timeParts[1];
        final timeFormat = DateFormat('hh:mm');
        final parsedTime = timeFormat.parse(timeStr);
        final scheduledTime = DateTime(now.year, now.month, now.day,
            parsedTime.hour + (period == 'PM' ? 12 : 0), parsedTime.minute);

        if (now.isAfter(scheduledTime)) {
          // Check if alert already exists
          // For simplicity, assume we add if not taken after time
          final alert = Alert(
            id: '',
            medicineId: medicine.id,
            medicineName: medicine.name,
            dosage: medicine.dosage,
            scheduledDate: now,
            scheduledTime: medicine.time,
            alertTime: now,
            isResolved: false,
          );
          await _service.addAlert(alert);
        }
      }
    }
  }
}
