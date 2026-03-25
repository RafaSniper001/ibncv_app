import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores oficiais extraídas da logo (Bíblia com Chama)
  static const Color ibncvRed = Color(0xFFD32F2F); // Vermelho da logo
  static const Color ibncvOrange = Color(0xFFFF9800); // Laranja da chama
  static const Color ibncvYellow = Color(0xFFFFEB3B); // Amarelo da chama
  static const Color darkBackground = Color(0xFF0A0A0A); // Fundo escuro premium

  static ThemeData get ibncvOfficialTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: ibncvRed,
      colorScheme: const ColorScheme.dark(
        primary: ibncvRed,
        secondary: ibncvOrange,
        tertiary: ibncvYellow,
        surface: Colors.black54,
      ),
      textTheme: GoogleFonts.montserratTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          labelLarge: TextStyle(color: ibncvOrange, fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cinzel(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
