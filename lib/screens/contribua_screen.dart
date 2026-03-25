import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glass_container.dart';
import '../theme/tema_ibncv.dart';

class ContribuaScreen extends StatelessWidget {
  const ContribuaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Dízimos e Ofertas', style: GoogleFonts.cinzel(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF121212), Color(0xFF1E1E1E), Color(0xFF121212)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  GlassContainer(
                    child: Column(
                      children: [
                         const Icon(Icons.volunteer_activism, size: 60, color: AppTheme.ibncvOrange),
                         const SizedBox(height: 20),
                         Text(
                           '"Cada um contribua segundo propôs no seu coração; não com tristeza, nem por constrangimento; porque Deus ama ao que dá com alegria."\n 2 Coríntios 9:7',
                           style: GoogleFonts.inter(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white70),
                           textAlign: TextAlign.center,
                         ),
                         const SizedBox(height: 40),
                         _buildFinanceOption('Chave PIX (E-mail)', 'ibncv@exemplo.com'),
                         const SizedBox(height: 20),
                         _buildFinanceOption('Chave PIX (CNPJ)', '00.000.000/0001-00'),
                         const SizedBox(height: 20),
                         const Divider(color: Colors.white24),
                         const SizedBox(height: 20),
                         Text('Transferência Bancária', style: GoogleFonts.cinzel(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                         const SizedBox(height: 10),
                         Text('Banco: 000 - Exemplo\nAgência: 0000\nConta: 00000-0\nNome: Igreja IBNCV', style: GoogleFonts.inter(fontSize: 14, color: Colors.white70), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceOption(String titulo, String dado) {
     return Container(
       width: double.infinity,
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: Colors.white.withOpacity(0.05),
         borderRadius: BorderRadius.circular(15),
         border: Border.all(color: AppTheme.ibncvOrange.withOpacity(0.3)),
       ),
       child: Column(
         children: [
           Text(titulo, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
           const SizedBox(height: 8),
           Text(dado, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w900, color: AppTheme.ibncvOrange)),
         ],
       ),
     );
  }
}
