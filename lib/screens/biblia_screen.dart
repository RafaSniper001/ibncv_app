import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glass_container.dart'; // Importar o novo componente

class BibliaScreen extends StatefulWidget {
  const BibliaScreen({super.key});

  @override
  State<BibliaScreen> createState() => _BibliaScreenState();
}

class _BibliaScreenState extends State<BibliaScreen> {
  final List<String> _livros = ['Gênesis', 'Êxodo', 'Levítico', 'Números', 'Deuteronômio', 'Josué', 'Juízes', 'Rute', '1 Samuel', '2 Samuel', '1 Reis', '2 Reis', '1 Crônicas', '2 Crônicas', 'Esdras', 'Neemias', 'Ester', 'Jó', 'Salmos', 'Provérbios', 'Eclesiastes', 'Cantares', 'Isaías', 'Jeremias', 'Lamentações', 'Ezequiel', 'Daniel', 'Oseias', 'Joel', 'Amós', 'Obadias', 'Jonas', 'Miqueias', 'Naum', 'Habacuque', 'Sofonias', 'Ageu', 'Zacarias', 'Malaquias', 'Mateus', 'Marcos', 'Lucas', 'João', 'Atos', 'Romanos', '1 Coríntios', '2 Coríntios', 'Gálatas', 'Efésios', 'Filipenses', 'Colossenses', '1 Tessalonicenses', '2 Tessalonicenses', '1 Timóteo', '2 Timóteo', 'Tito', 'Filemom', 'Hebreus', 'Tiago', '1 Pedro', '2 Pedro', '1 João', '2 João', '3 João', 'Judas', 'Apocalipse'];
  String _livroSelecionado = 'Gênesis';
  int _capituloSelecionado = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Bíblia Sagrada', style: GoogleFonts.cinzel(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Fundo Base (Vídeo ou Gradiente)
          Container(color: const Color(0xFF121212)),
          // Conteúdo com Vidro
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Seletores de Vidro
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    borderRadius: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton<String>(
                          value: _livroSelecionado,
                          dropdownColor: Colors.black87,
                          underline: const SizedBox(),
                          items: _livros.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(color: Colors.white)))).toList(),
                          onChanged: (newValue) => setState(() { _livroSelecionado = newValue!; _capituloSelecionado = 1; }),
                        ),
                        DropdownButton<int>(
                          value: _capituloSelecionado,
                          dropdownColor: Colors.black87,
                          underline: const SizedBox(),
                          items: List.generate(50, (index) => index + 1).map((int value) => DropdownMenuItem<int>(value: value, child: Text('Cap $value', style: const TextStyle(color: Colors.white)))).toList(),
                          onChanged: (newValue) => setState(() => _capituloSelecionado = newValue!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Área de Texto com Vidro
                  Expanded(
                    child: GlassContainer(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Text(
                          'No princípio, criou Deus os céus e a terra. E a terra era sem forma e vazia; e havia trevas sobre a face do abismo; e o Espírito de Deus se movia sobre a face das águas...',
                          style: GoogleFonts.inter(fontSize: 18, height: 1.6, color: Colors.white.withOpacity(0.9)),
                          textAlign: TextAlign.justify,
                        ),
                      ),
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
}
