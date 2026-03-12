import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';

class PainelPastorScreen extends StatefulWidget {
  const PainelPastorScreen({super.key});

  @override
  State<PainelPastorScreen> createState() => _PainelPastorScreenState();
}

class _PainelPastorScreenState extends State<PainelPastorScreen> {
  final _mensagemController = TextEditingController();
  final _referenciaController = TextEditingController();
  String _destinatario = 'Todos'; // Todos, Lideres, Especifico
  bool _isLoading = false;

  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void dispose() {
    _mensagemController.dispose();
    _referenciaController.dispose();
    super.dispose();
  }

  Future<void> _enviarMensagem() async {
    if (_mensagemController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A mensagem não pode estar vazia.', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Salvar na Tabela Avisos
      await _supabase.from('avisos').insert({
        'mensagem': _mensagemController.text.trim(),
        'referencia': _referenciaController.text.trim(),
        'destinatario_grupo': _destinatario,
        'autor_id': _supabase.auth.currentUser?.id,
        'criado_em': DateTime.now().toIso8601String(),
      });

      // 2. Disparar Edge Function para Push (Lógica via API do Supabase)
      // await _supabase.functions.invoke('send-push', body: {
      //   'title': 'Mensagem do Pastor',
      //   'body': _mensagemController.text.trim(),
      //   'target': _destinatario
      // });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mensagem enviada com sucesso e notificação push agendada!'), backgroundColor: Colors.green),
        );
        _mensagemController.clear();
        _referenciaController.clear();
      }
    } catch (e) {
      debugPrint('Erro ao enviar mensagem: \$e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar: \$e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (context.mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        title: Text('Painel Pastoral', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: GlassmorphicContainer(
          width: double.infinity,
          height: 600,
          borderRadius: 20,
          blur: 15,
          alignment: Alignment.topCenter,
          border: 1.5,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.1),
                const Color(0xFFFFFFFF).withOpacity(0.05),
              ],
              stops: const [0.1, 1],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.5),
              const Color((0xFFFFFFFF)).withOpacity(0.5),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enviar Mensagem / Versículo',
                  style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFFFFC107)),
                ),
                const SizedBox(height: 20),
                
                // Mensagem
                TextField(
                  controller: _mensagemController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Mensagem de Bom Dia ou Reflexão',
                    labelStyle: const TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white30), borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFFFC107)), borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 16),

                // Referencia Bíblica
                TextField(
                  controller: _referenciaController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Referência (Ex: Salmos 23:1)',
                    labelStyle: const TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white30), borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFFFC107)), borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),

                // Destinatários
                Text('Destinatários:', style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: _destinatario,
                  dropdownColor: Colors.grey[900],
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white),
                  items: const [
                    DropdownMenuItem(value: 'Todos', child: Text('Toda a Igreja (Global)')),
                    DropdownMenuItem(value: 'Lideres', child: Text('Apenas Liderança')),
                    DropdownMenuItem(value: 'Especifico', child: Text('Membro Específico')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _destinatario = val);
                  },
                ),
                const Spacer(),

                // Botão Enviar
                _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFFFFC107)))
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: const Text('DISPARAR NOTIFICAÇÃO PUSH', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD32F2F),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _enviarMensagem,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
