import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../widgets/glass_container.dart';

class BibliaScreen extends StatefulWidget {
  const BibliaScreen({super.key});

  @override
  State<BibliaScreen> createState() => _BibliaScreenState();
}

class _BibliaScreenState extends State<BibliaScreen> {
  final List<String> _livros = [
    'Gênesis', 'Êxodo', 'Levítico', 'Números', 'Deuteronômio', 'Josué', 'Juízes', 'Rute', '1 Samuel', '2 Samuel', '1 Reis', '2 Reis', '1 Crônicas', '2 Crônicas', 'Esdras', 'Neemias', 'Ester', 'Jó', 'Salmos', 'Provérbios', 'Eclesiastes', 'Cantares', 'Isaías', 'Jeremias', 'Lamentações', 'Ezequiel', 'Daniel', 'Oseias', 'Joel', 'Amós', 'Obadias', 'Jonas', 'Miqueias', 'Naum', 'Habacuque', 'Sofonias', 'Ageu', 'Zacarias', 'Malaquias',
    'Mateus', 'Marcos', 'Lucas', 'João', 'Atos', 'Romanos', '1 Coríntios', '2 Coríntios', 'Gálatas', 'Efésios', 'Filipenses', 'Colossenses', '1 Tessalonicenses', '2 Tessalonicenses', '1 Timóteo', '2 Timóteo', 'Tito', 'Filemom', 'Hebreus', 'Tiago', '1 Pedro', '2 Pedro', '1 João', '2 João', '3 João', 'Judas', 'Apocalipse'
  ];
  String _livroSelecionado = 'Gênesis';
  int _capituloSelecionado = 1;
  bool _isLoading = false;
  String? _erro;
  List<dynamic> _versiculos = [];

  @override
  void initState() {
    super.initState();
    _carregarCapitulo();
  }

  Future<void> _carregarCapitulo() async {
    setState(() {
      _isLoading = true;
      _erro = null;
    });

    try {
      final url = Uri.parse('https://bible-api.com/${Uri.encodeComponent(_livroSelecionado)}%20$_capituloSelecionado?translation=almeida');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _versiculos = data['verses'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _erro = 'Erro ao carregar o capítulo (${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro de conexão: Verifique sua internet.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Bíblia Sagrada', style: GoogleFonts.cinzel(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Fundo Base (Camada 1: Gradiente escuro)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF121212), Color(0xFF1E1E1E), Color(0xFF121212)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Overlay com Vidro Global (Camada 2: BackdropFilter)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          // Camada 3: Conteúdo
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
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _livroSelecionado,
                              dropdownColor: const Color(0xFF121212).withOpacity(0.9),
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                              items: _livros.map((String value) => DropdownMenuItem<String>(
                                  value: value, 
                                  child: Text(value, style: GoogleFonts.inter(color: Colors.white), overflow: TextOverflow.ellipsis)
                              )).toList(),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  setState(() { _livroSelecionado = newValue; _capituloSelecionado = 1; });
                                  _carregarCapitulo();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              isExpanded: true,
                              value: _capituloSelecionado,
                              dropdownColor: const Color(0xFF121212).withOpacity(0.9),
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                              items: List.generate(150, (index) => index + 1).map((int value) => DropdownMenuItem<int>(
                                  value: value, 
                                  child: Text('Capítulo $value', style: GoogleFonts.inter(color: Colors.white), overflow: TextOverflow.ellipsis)
                              )).toList(),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  setState(() { _capituloSelecionado = newValue; });
                                  _carregarCapitulo();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Área de Texto com Vidro
                  Expanded(
                    child: GlassContainer(
                      width: double.infinity,
                      borderRadius: 20,
                      padding: const EdgeInsets.all(16),
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator(color: Color(0xFFD32F2F)))
                          : _erro != null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.error_outline, color: Color(0xFFD32F2F), size: 48),
                                      const SizedBox(height: 16),
                                      Text(_erro!, style: GoogleFonts.inter(color: Colors.white), textAlign: TextAlign.center),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFFD32F2F),
                                        ),
                                        onPressed: _carregarCapitulo,
                                        child: Text('Tentar Novamente', style: GoogleFonts.inter(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                )
                              : _versiculos.isEmpty
                                  ? Center(child: Text('Nenhum versículo encontrado.', style: GoogleFonts.inter(color: Colors.white)))
                                  : ListView.builder(
                                      itemCount: _versiculos.length,
                                      itemBuilder: (context, index) {
                                        final versiculo = _versiculos[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 12.0),
                                          child: RichText(
                                            textAlign: TextAlign.justify,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '${versiculo['verse']} ',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(0xFFFFC107), // Amarelo/Laranja
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '${versiculo['text']}',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    height: 1.6,
                                                    color: Colors.white.withOpacity(0.9),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
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

