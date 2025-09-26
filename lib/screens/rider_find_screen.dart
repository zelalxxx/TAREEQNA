import 'package:flutter/material.dart';
import '../services/ride_service.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'carpool_preferences_screen.dart';


class RiderFindScreen extends StatefulWidget {
  const RiderFindScreen({super.key});

  @override
  State<RiderFindScreen> createState() => _RiderFindScreenState();
}

class _RiderFindScreenState extends State<RiderFindScreen> {
  final svc = RideService();
  final fromCtrl = TextEditingController();
  final toCtrl = TextEditingController();
  int seatCount = 1;
  List<Map<String, dynamic>> results = [];

  @override
  void dispose() {
    fromCtrl.dispose();
    toCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 8),

              // Title
              const Text(
                'Find a ride',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // FROM/TO Section
              const Text("Where are you going?", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),

              TextField(
                controller: fromCtrl,
                decoration: InputDecoration(
                  hintText: 'From',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: toCtrl,
                decoration: InputDecoration(
                  hintText: 'To',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),

              // WHEN section (static for now)
              const Text("When?", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text("Today, 5:30 PM", style: TextStyle(color: Colors.black54)),
              ),
              const SizedBox(height: 16),

              // SEAT section
              const Text("Seat needed?", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (seatCount > 1) {
                        setState(() {
                          seatCount--;
                        });
                      }
                    },
                  ),
                  Text("$seatCount", style: const TextStyle(fontSize: 16)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        seatCount++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // SEARCH BUTTON
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CarpoolPreferencesScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFDB5EFF), Color(0xFFAD59FF)],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // SEARCH RESULTS
              if (results.isNotEmpty) ...[
                const Divider(),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: results.length,
                  itemBuilder: (context, i) {
                    final r = results[i];
                    final ts = r['time'] as Timestamp;
                    final dt = ts.toDate();

                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 2,
                      child: ListTile(
                        title: Text("${r['from']['text']} → ${r['to']['text']}"),
                        subtitle: Text("${DateFormat('EEE, d MMM • HH:mm').format(dt)} · seats ${r['seats']} · JOD ${r['priceJOD'] ?? 0}"),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            final reqId = await svc.requestJoin(r['id']);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Requested (#$reqId)')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFAD59FF),
                          ),
                          child: const Text('Request'),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
