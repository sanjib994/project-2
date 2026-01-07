import 'package:flutter/material.dart';
import '../models/alert.dart';
import '../services/firestore_service.dart';

class AlertProvider with ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  List<Alert> _alerts = [];

  List<Alert> get alerts => _alerts;

  void fetchAlerts() {
    _service.getAlerts().listen((newList) {
      _alerts = newList;
      notifyListeners();
    });
  }

  Future<void> resolveAlert(String id) async {
    await _service.resolveAlert(id);
  }
}
