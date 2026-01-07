import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/medicine_provider.dart';
import '../../widgets/medicine_card.dart';
import '../../services/firestore_service.dart';
import 'medicine_history_screen.dart';

class ElderDashboard extends StatefulWidget {
  const ElderDashboard({super.key});

  @override
  State<ElderDashboard> createState() => _ElderDashboardState();
}

class _ElderDashboardState extends State<ElderDashboard> {
  @override
  void initState() {
    super.initState();
    // Start listening to the medicine list immediately
    Provider.of<MedicineProvider>(context, listen: false).fetchMedicines();
  }

  @override
  Widget build(BuildContext context) {
    final medProvider = Provider.of<MedicineProvider>(context);
    final today = DateFormat('EEEE').format(DateTime.now()); // e.g., "Monday"

    // Filter medicines for today
    final todaysMedicines =
        medProvider.medicines.where((med) => med.days.contains(today)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Medicines Today",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MedicineHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: todaysMedicines.isEmpty
          ? const Center(
              child: Text(
                "No medicines scheduled for today.",
                style: TextStyle(fontSize: 20, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: todaysMedicines.length,
              itemBuilder: (context, index) {
                final med = todaysMedicines[index];
                return MedicineCard(
                  medicine: med,
                  onTap: () {
                    // Toggle medicine status when Elder clicks it
                    FirestoreService()
                        .updateMedicineStatus(med.id, !med.isTaken);
                  },
                );
              },
            ),
    );
  }
}
