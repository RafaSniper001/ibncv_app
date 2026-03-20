import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

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
      final sucesso = await authService.enviarPedidoOracao(
        _nomeController.text,
        _pedidoController.text,
      );

      setState(() => _enviando = false);

      if (sucesso && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pedido enviado com sucesso! Deus te abençoe.'),
            backgroundColor: Colors.green,
          ),
        );
        _nomeController.clear();
        _pedidoController.clear();
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao enviar pedido. Tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() => _enviando = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro inesperado: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido de Oração', style: GoogleFonts.cinzel()),
        backgroundColor: const Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Como podemos orar por você?',
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nomeController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Seu Nome',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.white70),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Por favor, informe seu nome' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _pedidoController,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Seu Pedido de Oração',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                  prefixIcon: Icon(Icons.volunteer_activism, color: Colors.white70),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Por favor, descreva seu pedido' : null,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _enviando ? null : _enviarPedido,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: _enviando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('ENVIAR PEDIDO',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
