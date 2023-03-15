import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: const Color(0xFF2B2E4A),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.allan(
        textStyle: const TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
      ),
      headlineMedium: GoogleFonts.allan(
        textStyle: const TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      headlineSmall: GoogleFonts.allan(
        textStyle: const TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
      ),
      bodyLarge: GoogleFonts.allan(
        textStyle: const TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
      ),
      bodyMedium: GoogleFonts.allan(
        textStyle: const TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color(0xFFE84545))
        .copyWith(background: const Color(0xFFF4F4F4)),
  );
}
