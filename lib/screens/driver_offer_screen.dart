import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/ride_service.dart';

class DriverOfferScreen extends StatefulWidget {
  const DriverOfferScreen({super.key});

  @override
  State<DriverOfferScreen> createState() => _DriverOfferScreenState();
}

class _DriverOfferScreenState extends State<DriverOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  final svc = RideService();

  final fromCtrl = TextEditingController();
  final toCtrl = TextEditingController();
  final notesCtrl = TextEditingController();

  DateTime? when;
  int seats = 1;
  double price = 0;

  @override
  void dispose() {
    fromCtrl.dispose();
    toCtrl.dispose();
    notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(hours: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (d == null) return;

    final t = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
    if (t == null) return;

    setState(() => when = DateTime(d.year, d.month, d.day, t.hour, t.minute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Pickup Location
              const Text("Pickup Location", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _inputField(
                icon: Icons.location_on_outlined,
                hint: 'Text input / Map selector',
                controller: fromCtrl,
              ),

              const SizedBox(height: 16),
              const Text("Drop-off Location", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _inputField(
                icon: Icons.local_taxi_outlined,
                hint: 'Text input / Map selector',
                controller: toCtrl,
              ),

              const SizedBox(height: 16),
              const Text("Date & Time", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _pickDateTime,
                child: AbsorbPointer(
                  child: _inputField(
                    icon: Icons.calendar_month_outlined,
                    hint: when == null
                        ? 'Date & time picker'
                        : DateFormat('EEE, MMM d • h:mm a').format(when!),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Text("Available Seats", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _inputField(
                icon: Icons.person_outline,
                hint: 'Numeric input',
                keyboardType: TextInputType.number,
                initialValue: '$seats',
                onChanged: (v) => seats = int.tryParse(v) ?? 1,
              ),

              const SizedBox(height: 16),
              const Text("Price per Seat (optional)", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _inputField(
                icon: Icons.attach_money,
                hint: 'Numeric input',
                keyboardType: TextInputType.number,
                onChanged: (v) => price = double.tryParse(v) ?? 0,
              ),

              const SizedBox(height: 16),
              const Text("Notes", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _inputField(
                icon: Icons.note_alt_outlined,
                hint: 'Optional notes for passengers',
                controller: notesCtrl,
              ),

              const SizedBox(height: 28),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate() || when == null) return;

                    final id = await svc.createRide(
                      fromText: fromCtrl.text,
                      toText: toCtrl.text,
                      time: when!,
                      seats: seats,
                      priceJod: price,
                      notes: notesCtrl.text,
                    );

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ride created: $id')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAD59FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Make a Ride',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required IconData icon,
    String? hint,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    String? initialValue,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFFAD59FF)),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: (v) => (controller != null && v!.trim().isEmpty) ? 'Required' : null,
    );
  }
}
