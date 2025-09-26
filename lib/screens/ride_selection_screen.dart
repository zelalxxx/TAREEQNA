import 'package:flutter/material.dart';
import 'chat_screen.dart'; // Make sure you create this file as shown below

class RideSelectionScreen extends StatelessWidget {
  const RideSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example static list of rides – replace this with real Firebase data later
    final rideList = [
      {
        'timeFrom': '05:00 PM',
        'from': 'Lalokhair Karachi',
        'timeTo': '07:00 PM',
        'to': 'Latifabad Hyderabad',
        'price': '600',
        'driver': 'Ahmed Ali',
        'driverId': 'driver001',
        'distance': '10 mins away'
      },
      {
        'timeFrom': '03:15 PM',
        'from': 'Saddar Karachi',
        'timeTo': '05:30 PM',
        'to': 'Heerabad Hyderabad',
        'price': '600',
        'driver': 'Sara Khan',
        'driverId': 'driver002',
        'distance': '12 mins away'
      },
      {
        'timeFrom': '09:00 PM',
        'from': 'Karachi Airport',
        'timeTo': '11:00 PM',
        'to': 'Jamshoro Bypass',
        'price': '500',
        'driver': 'Omar Yusuf',
        'driverId': 'driver003',
        'distance': '15 mins away'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Choose a Ride"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: rideList.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final ride = rideList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FROM and TO info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT SIDE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ride['timeFrom']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.circle, color: Color(0xFFDB5EFF), size: 12),
                            const SizedBox(width: 8),
                            Text(ride['from']!),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.luggage, size: 14, color: Colors.grey),
                              SizedBox(width: 6),
                              Icon(Icons.music_note, size: 14, color: Colors.grey),
                              SizedBox(width: 6),
                              Icon(Icons.smoking_rooms, size: 14, color: Colors.grey),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(ride['timeTo']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.circle_outlined, color: Color(0xFFDB5EFF), size: 12),
                            const SizedBox(width: 8),
                            Text(ride['to']!),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text("Rs: ${ride['price']}", style: const TextStyle(color: Color(0xFFDB5EFF), fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),

                // DRIVER INFO + CHAT BUTTON
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ride['driver']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(ride['distance']!, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: const Text('Chat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFAD59FF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              driverName: ride['driver']!,
                              driverId: ride['driverId']!,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
