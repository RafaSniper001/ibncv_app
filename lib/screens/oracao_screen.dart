import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/glass_container.dart';

class OracaoScreen extends StatefulWidget {
  const OracaoScreen({super.key});

  @override
  State<OracaoScreen> createState() => _OracaoScreenState();
}

class _OracaoScreenState extends State<OracaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _pedidoController = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _pedidoController.dispose();
    super.dispose();
  }

  Future<void> _enviarPedido() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _enviando = true);
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final sucesso = await authService.enviarPedidoOracao(_nomeController.text, _pedidoController.text);
      setState(() => _enviando = false);
      if (sucesso && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pedido enviado com sucesso! Deus te abençoe.'), backgroundColor: Colors.green));
        _nomeController.clear();
        _pedidoController.clear();
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro ao enviar pedido. Tente novamente.'), backgroundColor: Colors.red));
      }
    } catch (e) {
      setState(() => _enviando = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro inesperado: $e'), backgroundColor: Colors.red));
    }
  }
  Widget _buildNeonTextField(String label, TextEditingController controller, Color neonColor, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.montserrat(color: neonColor, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: neonColor.withOpacity(0.1), blurRadius: 10, spreadRadius: 1),
            ],
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black.withOpacity(0.5),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: neonColor.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: neonColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) => value == null || value.isEmpty ? 'Por favor, preencha este campo' : null,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Pedido de Oração', style: GoogleFonts.cinzel(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Fundo Base
          Container(color: const Color(0xFF121212)),
          // Conteúdo com Vidro
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GlassContainer(
                      child: Column(
                        children: [
                          Text(
                            'Como podemos orar por você?',
                            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          _buildNeonTextField('SEU NOME', _nomeController, const Color(0xFFD32F2F)),
                          const SizedBox(height: 20),
                          _buildNeonTextField('SEU PEDIDO DE ORAÇÃO', _pedidoController, const Color(0xFFFF9800), maxLines: 5),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: _enviando ? null : _enviarPedido,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Usaremos um Container com gradiente por baixo
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [Color(0xFFD32F2F), Color(0xFFFF9800)]),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                alignment: Alignment.center,
                                child: _enviando
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text('ENVIAR PEDIDO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
