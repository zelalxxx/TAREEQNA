import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String driverName;
  final String driverId;

  const ChatScreen({
    super.key,
    required this.driverName,
    required this.driverId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgCtrl = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': '',
      'sender': 'driver',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 2)),
      'seen': true,
    },
    {
      'text': '',
      'sender': 'me',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 1)),
      'seen': true,
    }
  ];

  void _sendMessage() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': text,
        'sender': 'me',
        'timestamp': DateTime.now(),
        'seen': false,
      });
    });

    _msgCtrl.clear();
    // TODO: Push to Firestore or backend if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.close, color: Colors.black),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Karachi to Hyderabad',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('Today, 1 Passenger',
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                ],
              ),
            ),

            const Divider(height: 0),

            // Messages
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: _messages.length,
                reverse: false,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isMe = msg['sender'] == 'me';

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                            color: isMe ? const Color(0xFFF0D9FF) : Colors.grey.shade300,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(18),
                              topRight: const Radius.circular(18),
                              bottomLeft: Radius.circular(isMe ? 18 : 0),
                              bottomRight: Radius.circular(isMe ? 0 : 18),
                            ),
                          ),
                          child: Text(msg['text'],
                              style: const TextStyle(fontSize: 15)),
                        ),
                        Text(
                          "Seen • ${DateFormat('HH:mm').format(msg['timestamp'])}",
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Payment Note
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Only pay driver in cash in the car",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Input Field
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msgCtrl,
                      decoration: InputDecoration(
                        hintText: "Your message",
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: _sendMessage,
                    borderRadius: BorderRadius.circular(30),
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFDB5EFF),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
