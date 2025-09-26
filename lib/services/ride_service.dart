import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RideService {
  final _db = FirebaseFirestore.instance;
  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  Future<String> createRide({
    required String fromText,
    required String toText,
    required DateTime time,
    required int seats,
    double priceJod = 0,
    String notes = '',
  }) async {
    final doc = await _db.collection('rides').add({
      'driverId': _uid,
      'from': {'text': fromText, 'lat': 0.0, 'lng': 0.0},
      'to': {'text': toText, 'lat': 0.0, 'lng': 0.0},
      'time': Timestamp.fromDate(time),
      'seats': seats,
      'priceJOD': priceJod,
      'notes': notes,
      'status': 'open',
      'createdAt': FieldValue.serverTimestamp(),
    });
    return doc.id;
  }

  Future<List<Map<String, dynamic>>> searchRides({
    String? fromText,
    String? toText,
  }) async {
    Query q = _db.collection('rides').where('status', isEqualTo: 'open');
    if (fromText != null && fromText.isNotEmpty) {
      q = q.where('from.text', isEqualTo: fromText);
    }
    if (toText != null && toText.isNotEmpty) {
      q = q.where('to.text', isEqualTo: toText);
    }
    final snap = await q.orderBy('time').limit(25).get();
    return snap.docs.map((d) => {'id': d.id, ...d.data() as Map<String, dynamic>}).toList();
  }

  Future<String> requestJoin(String rideId) async {
    final ref = await _db.collection('rideRequests').add({
      'rideId': rideId,
      'riderId': _uid,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
    return ref.id;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> myRequestsStream() {
    return _db.collection('rideRequests')
        .where('riderId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
