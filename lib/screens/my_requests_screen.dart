import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/ride_service.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final svc = RideService();
    return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
      stream: svc.myRequestsStream(),
      builder: (ctx, snap){
        if(!snap.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snap.data!.docs;
        if (docs.isEmpty) return const Center(child: Text('No requests yet'));
        return ListView(
          children: docs.map((d)=> ListTile(
            title: Text('Request ${d.id}'),
            subtitle: Text('status: ${d['status']}'),
          )).toList(),
        );
      },
    );
  }
}
