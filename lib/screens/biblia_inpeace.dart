import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BibliaInPeace extends StatefulWidget {
  const BibliaInPeace({super.key});

  @override
  State<BibliaInPeace> createState() => _BibliaInPeaceState();
}

class _BibliaInPeaceState extends State<BibliaInPeace> {
  final List<String> _livros = ['Gênesis', 'Êxodo', 'Levítico', 'Números', 'Deuteronômio', 'Josué', 'Juízes', 'Rute', '1 Samuel', '2 Samuel', '1 Reis', '2 Reis', '1 Crônicas', '2 Crônicas', 'Esdras', 'Neemias', 'Ester', 'Jó', 'Salmos', 'Provérbios', 'Eclesiastes', 'Cantares', 'Isaías', 'Jeremias', 'Lamentações', 'Ezequiel', 'Daniel', 'Oseias', 'Joel', 'Amós', 'Obadias', 'Jonas', 'Miqueias', 'Naum', 'Habacuque', 'Sofonias', 'Ageu', 'Zacarias', 'Malaquias', 'Mateus', 'Marcos', 'Lucas', 'João', 'Atos', 'Romanos', '1 Coríntios', '2 Coríntios', 'Gálatas', 'Efésios', 'Filipenses', 'Colossenses', '1 Tessalonicenses', '2 Tessalonicenses', '1 Timóteo', '2 Timóteo', 'Tito', 'Filemom', 'Hebreus', 'Tiago', '1 Pedro', '2 Pedro', '1 João', '2 João', '3 João', 'Judas', 'Apocalipse'];
  String _livroSelecionado = 'Gênesis';
  int _capituloSelecionado = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('BÍBLIA', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Fundo Escuro Minimalista (O vídeo continua rodando por baixo no app real)
          Container(color: Colors.black),
          SafeArea(
            child: Column(
              children: [
                // Seletor Minimalista
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSelector(_livroSelecionado, () { /* Abrir Lista */ }),
                      const SizedBox(width: 20),
                      _buildSelector('CAP $_capituloSelecionado', () { /* Abrir Lista */ }),
                    ],
                  ),
                ),
                // Texto Bíblico Ultra-Clean
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      'No princípio, criou Deus os céus e a terra. E a terra era sem forma e vazia; e havia trevas sobre a face do abismo; e o Espírito de Deus se movia sobre a face das águas...',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        height: 1.8,
                        color: Colors.white.withOpacity(0.85),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelector(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(label, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
