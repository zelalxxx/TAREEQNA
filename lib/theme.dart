import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TColors {
  static const blue   = Color(0xFF2563EB);
  static const purple = Color(0xFF7C3AED);
  static const bg     = Color(0xFFF7F8FA);
}

ThemeData tareeqnaTheme() {
  final cs = ColorScheme.fromSeed(seedColor: TColors.blue).copyWith(
    primary: TColors.blue,
    secondary: TColors.purple,
  );

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: cs,
    scaffoldBackgroundColor: TColors.bg,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: TColors.purple,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    ),
  );

  // Apply Lora to all text
  final loraText = GoogleFonts.loraTextTheme(base.textTheme).apply(
    bodyColor: Colors.black87,
    displayColor: Colors.black87,
  );

  return base.copyWith(
    textTheme: loraText,
    appBarTheme: base.appBarTheme.copyWith(
      titleTextStyle: GoogleFonts.lora(
          fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
    ),
  );
}

/// Gradient AppBar helper (unchanged)
PreferredSizeWidget gradientAppBar(String title) => AppBar(
  title: Text(title, style: GoogleFonts.lora(fontWeight: FontWeight.w700)),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [TColors.blue, TColors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
);
