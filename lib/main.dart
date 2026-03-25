import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/home_ibncv.dart';
import 'theme/tema_ibncv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zefitvdaxjjwwisqkckr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InplZml0dmRheGpqd3dpc3FrY2tyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMzMTY4MjQsImV4cCI6MjA4ODg5MjgyNH0.ZXJ7kI4ea82lTYWhELZOEcGKgyKZF6TyCma1sBaXGSY',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const IBNCVApp(),
    ),
  );
}

class IBNCVApp extends StatelessWidget {
  const IBNCVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IBNCV',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.ibncvOfficialTheme,
      home: const HomeIBNCV(),
    );
  }
}
