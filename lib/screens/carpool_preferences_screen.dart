import 'package:flutter/material.dart';
import 'ride_selection_screen.dart';


class CarpoolPreferencesScreen extends StatefulWidget {
  const CarpoolPreferencesScreen({super.key});

  @override
  State<CarpoolPreferencesScreen> createState() => _CarpoolPreferencesScreenState();
}

class _CarpoolPreferencesScreenState extends State<CarpoolPreferencesScreen> {
  bool allowLuggage = false;
  bool musicAllowed = false;
  bool smokingAllowed = false;
  String genderPreference = 'Any';

  final List<String> genderOptions = ['Any', 'Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carpooling Preferences"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            preferenceRow(Icons.luggage, "Allow Luggage", allowLuggage, (val) {
              setState(() => allowLuggage = val);
            }),
            const SizedBox(height: 12),
            preferenceRow(Icons.music_note, "Music Allowed", musicAllowed, (val) {
              setState(() => musicAllowed = val);
            }),
            const SizedBox(height: 12),
            preferenceRow(Icons.smoking_rooms, "Smoking Allowed", smokingAllowed, (val) {
              setState(() => smokingAllowed = val);
            }),
            const SizedBox(height: 12),

            const Text("Gender Preference", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFAD59FF)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: genderPreference,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down),
                items: genderOptions.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => genderPreference = val);
                  }
                },
              ),
            ),

            const Spacer(),

            // NEXT BUTTON
            GestureDetector(
              onTap: () {
                // Proceed to results or next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RideSelectionScreen()),
                ); // for now just go back
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
                  "Next",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget preferenceRow(IconData icon, String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFFAD59FF)),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: Color(0xFFAD59FF),
        ),
      ],
    );
  }
}
