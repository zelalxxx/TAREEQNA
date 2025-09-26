import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme.dart';
import 'screens/auth/auth_gate.dart';
import 'screens/auth/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TEMP: force sign-out ONCE to clear any saved session (anon/email).
  // Remove this line after you see the Login screen once.
  // await FirebaseAuth.instance.signOut();

  runApp(const TareeqnaApp());
}

class TareeqnaApp extends StatelessWidget {
  const TareeqnaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tareeqna',
      debugShowCheckedModeBanner: false,
      theme: tareeqnaTheme(),
      home: const WelcomeScreen(),   // ← must point to AuthGate
    );
  }
}
