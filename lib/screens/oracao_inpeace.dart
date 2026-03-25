import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OracaoInPeace extends StatefulWidget {
  const OracaoInPeace({super.key});

  @override
  State<OracaoInPeace> createState() => _OracaoInPeaceState();
}

class _OracaoInPeaceState extends State<OracaoInPeace> {
  final _nomeController = TextEditingController();
  final _pedidoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('ORAÇÕES', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(color: Colors.black),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Como podemos orar por você?',
                    style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 50),
                  // Campo Nome Minimalista
                  _buildInPeaceField('SEU NOME', _nomeController),
                  const SizedBox(height: 30),
                  // Campo Pedido Minimalista
                  _buildInPeaceField('SEU PEDIDO', _pedidoController, maxLines: 5),
                  const SizedBox(height: 60),
                  // Botão InPeace (Centralizado e Clean)
                  Center(
                    child: InkWell(
                      onTap: () { /* Enviar */ },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          'ENVIAR PEDIDO',
                          style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
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

  Widget _buildInPeaceField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white54, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ],
    );
  }
}
