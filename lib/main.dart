import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zefitvdaxjjwwisqkckr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InplZml0dmRheGpqd3dpc3FrY2tyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMzMTY4MjQsImV4cCI6MjA4ODg5MjgyNH0.ZXJ7kI4ea82lTYWhELZOEcGKgyKZF6TyCma1sBaXGSY',
  );

  runApp(const IBNCVApp());
}

class IBNCVApp extends StatelessWidget {
  const IBNCVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IBNCV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD32F2F), // Vermelho Oficial
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
            primary: Color(0xFFD32F2F), secondary: Color(0xFFFFC107)), // Amarelo Oficial
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
