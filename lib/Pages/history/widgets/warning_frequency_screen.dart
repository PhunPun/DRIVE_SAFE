import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WarningFrequencyScreen extends StatefulWidget {
  const WarningFrequencyScreen({super.key});

  @override
  State<WarningFrequencyScreen> createState() => _WarningFrequencyScreenState();
}

class _WarningFrequencyScreenState extends State<WarningFrequencyScreen> {
  Map<String, int> warningCountPerDay = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('user_status')
        .where('status', isEqualTo: 'drowse')
        .orderBy('timestamp', descending: true)
        .get();

    final countMap = <String, int>{};
    for (var doc in snapshot.docs) {
      final timestamp = (doc['timestamp'] as Timestamp?)?.toDate();
      if (timestamp != null) {
        final dayKey = DateFormat('dd/MM/yyyy').format(timestamp);
        countMap[dayKey] = (countMap[dayKey] ?? 0) + 1;
      }
    }

    setState(() {
      warningCountPerDay = countMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortedKeys = warningCountPerDay.keys.toList()..sort((a, b) {
      final dateA = DateFormat('dd/MM/yyyy').parse(a);
      final dateB = DateFormat('dd/MM/yyyy').parse(b);
      return dateB.compareTo(dateA); // newest first
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Tần suất cảnh báo buồn ngủ')),
      body: warningCountPerDay.isEmpty
          ? const Center(child: Text("Không có dữ liệu buồn ngủ"))
          : ListView.builder(
              itemCount: sortedKeys.length,
              itemBuilder: (context, index) {
                final date = sortedKeys[index];
                final count = warningCountPerDay[date]!;
                return ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text('Ngày $date'),
                  trailing: Text('$count lần', style: const TextStyle(fontSize: 18)),
                );
              },
            ),
    );
  }
}
