import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BibliaScreen extends StatefulWidget {
  const BibliaScreen({super.key});

  @override
  State<BibliaScreen> createState() => _BibliaScreenState();
}

class _BibliaScreenState extends State<BibliaScreen> {
  final List<String> _livros = [
    'Gênesis', 'Êxodo', 'Levítico', 'Números', 'Deuteronômio',
    'Josué', 'Juízes', 'Rute', '1 Samuel', '2 Samuel',
    '1 Reis', '2 Reis', '1 Crônicas', '2 Crônicas', 'Esdras',
    'Neemias', 'Ester', 'Jó', 'Salmos', 'Provérbios',
    'Eclesiastes', 'Cantares', 'Isaías', 'Jeremias', 'Lamentações',
    'Ezequiel', 'Daniel', 'Oseias', 'Joel', 'Amós',
    'Obadias', 'Jonas', 'Miqueias', 'Naum', 'Habacuque',
    'Sofonias', 'Ageu', 'Zacarias', 'Malaquias',
    'Mateus', 'Marcos', 'Lucas', 'João', 'Atos',
    'Romanos', '1 Coríntios', '2 Coríntios', 'Gálatas', 'Efésios',
    'Filipenses', 'Colossenses', '1 Tessalonicenses', '2 Tessalonicenses',
    '1 Timóteo', '2 Timóteo', 'Tito', 'Filemom', 'Hebreus',
    'Tiago', '1 Pedro', '2 Pedro', '1 João', '2 João',
    '3 João', 'Judas', 'Apocalipse'
  ];

  String _livroSelecionado = 'Gênesis'; 
  int _capituloSelecionado = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bíblia Sagrada', style: GoogleFonts.cinzel()),
        backgroundColor: const Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _livroSelecionado,
                  dropdownColor: Colors.black87,
                  items: _livros.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _livroSelecionado = newValue!;
                      _capituloSelecionado = 1;
                    });
                  },
                ),
                DropdownButton<int>(
                  value: _capituloSelecionado,
                  dropdownColor: Colors.black87,
                  items: List.generate(50, (index) => index + 1).map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('Cap $value', style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _capituloSelecionado = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Text(
                'No princípio, criou Deus os céus e a terra. E a terra era sem forma e vazia; e havia trevas sobre a face do abismo; e o Espírito de Deus se movia sobre a face das águas...',
                style: GoogleFonts.inter(fontSize: 18, height: 1.5, color: Colors.white70),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
