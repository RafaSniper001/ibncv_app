import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BibliaScreen extends StatefulWidget {
  const BibliaScreen({super.key});

  @override
  State<BibliaScreen> createState() => _BibliaScreenState();
}

class _BibliaScreenState extends State<BibliaScreen> {
  final Map<String, int> _capitulosPorLivro = {
    'Gênesis': 50, 'Êxodo': 40, 'Levítico': 27, 'Números': 36, 'Deuteronômio': 34,
    'Josué': 24, 'Juízes': 21, 'Rute': 4, '1 Samuel': 31, '2 Samuel': 24,
    '1 Reis': 22, '2 Reis': 25, '1 Crônicas': 29, '2 Crônicas': 36, 'Esdras': 10,
    'Neemias': 13, 'Ester': 10, 'Jó': 42, 'Salmos': 150, 'Provérbios': 31,
    'Eclesiastes': 12, 'Cantares': 8, 'Isaías': 66, 'Jeremias': 52, 'Lamentações': 5,
    'Ezequiel': 48, 'Daniel': 12, 'Oseias': 14, 'Joel': 3, 'Amós': 9,
    'Obadias': 1, 'Jonas': 4, 'Miqueias': 7, 'Naum': 3, 'Habacuque': 3,
    'Sofonias': 3, 'Ageu': 2, 'Zacarias': 14, 'Malaquias': 4,
    'Mateus': 28, 'Marcos': 16, 'Lucas': 24, 'João': 21, 'Atos': 28,
    'Romanos': 16, '1 Coríntios': 16, '2 Coríntios': 13, 'Gálatas': 6, 'Efésios': 6,
    'Filipenses': 4, 'Colossenses': 4, '1 Tessalonicenses': 5, '2 Tessalonicenses': 3,
    '1 Timóteo': 6, '2 Timóteo': 4, 'Tito': 3, 'Filemom': 1, 'Hebreus': 13,
    'Tiago': 5, '1 Pedro': 5, '2 Pedro': 3, '1 João': 5, '2 João': 1,
    '3 João': 1, 'Judas': 1, 'Apocalipse': 22,
  };

  late String _livroSelecionado; 
  late int _capituloSelecionado;
  
  bool _isLoading = false;
  String _bibliaContent = '';

  @override
  void initState() {
    super.initState();
    _livroSelecionado = _capitulosPorLivro.keys.first;
    _capituloSelecionado = 1;
    _carregarCapitulo();
  }

  Future<void> _carregarCapitulo() async {
    setState(() {
      _isLoading = true;
      _bibliaContent = '';
    });

    try {
      // Converte espaços para + como esperado pela bible-api
      String livroFormatado = Uri.encodeComponent(_livroSelecionado);
      final url = Uri.parse('https://bible-api.com/$livroFormatado+$_capituloSelecionado?translation=almeida');
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final verses = data['verses'] as List;
        
        StringBuffer buffer = StringBuffer();
        for (var verse in verses) {
          buffer.write('${verse['verse']} ${verse['text']} ');
        }
        
        setState(() {
          _bibliaContent = buffer.toString().trim();
        });
      } else {
        setState(() {
          _bibliaContent = 'Não foi possível carregar o capítulo. Verifique sua conexão. (Erro: ${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _bibliaContent = 'Ocorreu um erro ao carregar a Bíblia: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalCapitulos = _capitulosPorLivro[_livroSelecionado] ?? 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bíblia Sagrada', style: GoogleFonts.cinzel()),
        backgroundColor: const Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.black.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _livroSelecionado,
                    dropdownColor: Colors.black87,
                    items: _capitulosPorLivro.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null && newValue != _livroSelecionado) {
                        setState(() {
                          _livroSelecionado = newValue;
                          // Valida se o capítulo selecionado ainda é válido para o novo livro
                          if (_capituloSelecionado > (_capitulosPorLivro[newValue] ?? 1)) {
                            _capituloSelecionado = 1;
                          }
                        });
                        _carregarCapitulo();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: _capituloSelecionado,
                    dropdownColor: Colors.black87,
                    items: List.generate(totalCapitulos, (index) => index + 1).map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('Cap $value', style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null && newValue != _capituloSelecionado) {
                        setState(() {
                          _capituloSelecionado = newValue;
                        });
                        _carregarCapitulo();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading 
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFD32F2F)))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      _bibliaContent,
                      style: GoogleFonts.inter(fontSize: 18, height: 1.6, color: Colors.white70),
                      textAlign: TextAlign.justify,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
