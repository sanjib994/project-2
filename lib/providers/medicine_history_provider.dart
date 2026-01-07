import 'package:flutter/material.dart';
import '../models/medicine_history.dart';
import '../services/firestore_service.dart';

class MedicineHistoryProvider with ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  List<MedicineHistory> _history = [];

  List<MedicineHistory> get history => _history;

  void fetchHistory() {
    _service.getMedicineHistory().listen((newList) {
      _history = newList;
      notifyListeners();
    });
  }
}
