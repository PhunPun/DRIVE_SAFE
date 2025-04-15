import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Time extends StatelessWidget {
  const Time({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Chưa đăng nhập")),
      );
    }

    final statusRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('user_status')
        .orderBy('timestamp', descending: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Lịch sử trạng thái')),
      body: StreamBuilder<QuerySnapshot>(
        stream: statusRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Không có dữ liệu"));
          }

          final statusDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: statusDocs.length,
            itemBuilder: (context, index) {
              final data = statusDocs[index].data() as Map<String, dynamic>;
              final status = data['status'] ?? 'unknown';
              final timestamp = (data['timestamp'] as Timestamp?)?.toDate();
              final formattedTime = timestamp != null
                  ? DateFormat('dd/MM/yyyy HH:mm:ss').format(timestamp)
                  : 'Không rõ thời gian';

              return ListTile(
                leading: Icon(
                  status == 'drowse' ? Icons.warning : Icons.check_circle,
                  color: status == 'drowse' ? Colors.orange : Colors.green,
                ),
                title: Text(status.toUpperCase()),
                subtitle: Text(formattedTime),
              );
            },
          );
        },
      ),
    );
  }
}
