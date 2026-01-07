import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/alert_provider.dart';
import '../../models/alert.dart';

class CaregiverAlertsScreen extends StatefulWidget {
  const CaregiverAlertsScreen({super.key});

  @override
  State<CaregiverAlertsScreen> createState() => _CaregiverAlertsScreenState();
}

class _CaregiverAlertsScreenState extends State<CaregiverAlertsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AlertProvider>(context, listen: false).fetchAlerts();
  }

  @override
  Widget build(BuildContext context) {
    final alertProvider = Provider.of<AlertProvider>(context);
    final unresolvedAlerts =
        alertProvider.alerts.where((a) => !a.isResolved).toList();
    final resolvedAlerts =
        alertProvider.alerts.where((a) => a.isResolved).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alerts",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: alertProvider.alerts.isEmpty
          ? const Center(
              child: Text(
                "No alerts available.",
                style: TextStyle(fontSize: 20, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            )
          : ListView(
              children: [
                if (unresolvedAlerts.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Unresolved Alerts",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  ...unresolvedAlerts.map(
                      (alert) => AlertCard(alert: alert, isUnresolved: true)),
                ],
                if (resolvedAlerts.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Resolved Alerts",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  ...resolvedAlerts.map(
                      (alert) => AlertCard(alert: alert, isUnresolved: false)),
                ],
              ],
            ),
    );
  }
}

class AlertCard extends StatelessWidget {
  final Alert alert;
  final bool isUnresolved;

  const AlertCard({super.key, required this.alert, required this.isUnresolved});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isUnresolved ? Colors.red.shade50 : Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isUnresolved ? Icons.warning : Icons.check_circle,
                  size: 40,
                  color: isUnresolved ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.medicineName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Dosage: ${alert.dosage}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Scheduled: ${dateFormat.format(alert.scheduledDate)} at ${alert.scheduledTime}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Alert Time: ${timeFormat.format(alert.alertTime)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isUnresolved ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isUnresolved ? 'Unresolved' : 'Resolved',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    if (isUnresolved)
                      ElevatedButton(
                        onPressed: () => _resolveAlert(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Resolve'),
                      ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _contactElder,
                      icon: const Icon(Icons.phone),
                      label: const Text('Call'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _resolveAlert(BuildContext context) {
    Provider.of<AlertProvider>(context, listen: false).resolveAlert(alert.id);
  }

  void _contactElder() async {
    // Assuming a phone number, in real app get from patient profile
    final Uri phoneUri =
        Uri(scheme: 'tel', path: '+1234567890'); // Replace with actual number
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      // Handle error
    }
  }
}
