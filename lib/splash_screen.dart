import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'widgets/app_drawer.dart';
import 'screens/biblia_screen.dart';
import 'screens/oracao_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  Map<String, dynamic>? _ultimoAviso;

  @override
  void initState() {
    super.initState();
    // Buscar último aviso do pastor
    _fetchUltimoAviso();

    // Inicia o vídeo de background (placeholder de adoração)
    _controller = VideoPlayerController.asset('assets/videos/adoration_bg.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        setState(() {});
      });
  }

  Future<void> _fetchUltimoAviso() async {
    try {
       final response = await Supabase.instance.client
           .from('avisos')
           .select()
           .order('criado_em', ascending: false)
           .limit(1)
           .maybeSingle();

       if (response != null && mounted) {
         setState(() {
           _ultimoAviso = response;
         });
       }
    } catch(e) {
       debugPrint("Sem avisos no banco");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
         backgroundColor: Colors.transparent,
         elevation: 0,
         centerTitle: true,
         title: Text('IBNCV', style: GoogleFonts.cinzel(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      drawer: const AppDrawer(), // Componente de Menu Lateral que dependerá da Role
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Camada de Video Background
          _controller.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
              : const Center(child: CircularProgressIndicator(color: Color(0xFFD32F2F))),
          
          // 2. Camada Gradiente Escura sobre o vídeo
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // 3. Camada Superior: Menu Grid Glassmorphism
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   Text(
                    "BEM-VINDO À SUA \nCASA ESPIRITUAL",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // CARD DINÂMICO - AVISO DO PASTOR
                  if (_ultimoAviso != null)
                   Container(
                     width: double.infinity,
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(
                       color: const Color(0xFFD32F2F).withOpacity(0.85),
                       borderRadius: BorderRadius.circular(15),
                       border: Border.all(color: const Color(0xFFFFC107).withOpacity(0.5)),
                       boxShadow: [
                         BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)
                       ]
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [
                             const Icon(Icons.record_voice_over, color: Color(0xFFFFC107), size: 18),
                             const SizedBox(width: 8),
                             Text('Mensagem Pastoral', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12, color: const Color(0xFFFFC107))),
                           ],
                         ),
                         const SizedBox(height: 8),
                         Text(
                           '"\${_ultimoAviso!["mensagem"]}"',
                           style: GoogleFonts.inter(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white),
                         ),
                         if (_ultimoAviso!["referencia"] != null && _ultimoAviso!["referencia"].toString().isNotEmpty)
                           Padding(
                             padding: const EdgeInsets.only(top: 8.0),
                             child: Text('- \${_ultimoAviso!["referencia"]}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70)),
                           )
                       ],
                     ),
                   ),

                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      physics: const NeverScrollableScrollPhysics(), // Evitar rolagem se couber
                      children: [
                        _buildGlassCard(context, Icons.menu_book, 'Bíblia', onTap: () {
  Navigator.push(context, MaterialPageRoute(builder: (context) => const BibliaScreen()));
}),
                        _buildGlassCard(context, Icons.volunteer_activism, 'Orações', onTap: () {
  Navigator.push(context, MaterialPageRoute(builder: (context) => const OracaoScreen()));
}),
                        _buildGlassCard(context, Icons.video_library, 'Cultos & Mídia', onTap: () {
                           // Lógica de Mídia
                        }),
                        _buildGlassCard(context, Icons.calendar_month, 'Agenda', onTap: () {
                           // Lógica da Agenda/Check-in
                        }),
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

  Widget _buildGlassCard(BuildContext context, IconData icon, String title, {required VoidCallback onTap}) {
     return GestureDetector(
       onTap: onTap,
       child: GlassmorphicContainer(
         width: double.infinity,
         height: double.infinity,
         borderRadius: 20,
         blur: 15,
         alignment: Alignment.center,
         border: 1.5,
         linearGradient: LinearGradient(
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
             colors: [
               const Color(0xFFffffff).withOpacity(0.1),
               const Color(0xFFFFFFFF).withOpacity(0.05),
             ],
             stops: const [
               0.1,
               1,
             ]),
         borderGradient: LinearGradient(
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
           colors: [
             const Color(0xFFffffff).withOpacity(0.5),
             const Color((0xFFFFFFFF)).withOpacity(0.5),
           ],
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Icon(icon, size: 40, color: const Color(0xFFFFC107)), // Ícones em Amarelo Ouro
             const SizedBox(height: 12),
             Text(
               title,
               style: const TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w600,
                 color: Colors.white,
               ),
             ),
           ],
         ),
       ),
     );
  }
}
// Remover Scaffold falso AppDrawer
