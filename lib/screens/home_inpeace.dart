import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'biblia_inpeace.dart';
import 'oracao_inpeace.dart';

class HomeInPeace extends StatefulWidget {
  const HomeInPeace({super.key});

  @override
  State<HomeInPeace> createState() => _HomeInPeaceState();
}

class _HomeInPeaceState extends State<HomeInPeace> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Vídeo de fundo em loop com o vídeo oficial cristão
    _controller = VideoPlayerController.asset(
      'assets/videos/adoration_bg.mp4'
    )..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
        setState(() {});
      });
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
      body: Stack(
        children: [
          // 1. Vídeo de Fundo (100% da tela)
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.isInitialized ? _controller.value.size.width : 100,
                height: _controller.value.isInitialized ? _controller.value.size.height : 100,
                child: _controller.value.isInitialized ? VideoPlayer(_controller) : Container(),
              ),
            ),
          ),
          // 2. Overlay Escuro Gradiente (Para leitura dos ícones)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          // 3. Conteúdo da Interface
          SafeArea(
            child: Column(
              children: [
                // Header: Configurações e Perfil
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.settings_outlined, color: Colors.white, size: 28),
                      const Icon(Icons.account_circle_outlined, color: Colors.white, size: 28),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                // Logótipo Central (Substituir pela imagem branca)
                Column(
                  children: [
                    const Icon(Icons.house_outlined, size: 80, color: Colors.white), // Placeholder do logo
                    const SizedBox(height: 10),
                    Text(
                      'iban',
                      style: GoogleFonts.montserrat(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -2,
                      ),
                    ),
                    Text(
                      'UMA IGREJA ACOLHEDORA',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        color: Colors.white70,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
                // Grelha de Ícones Lineares (Estilo InPeace)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                    children: [
                      _buildLinearIcon(Icons.church_outlined, 'IGREJA'),
                      _buildLinearIcon(Icons.article_outlined, 'PUBLICAÇÕES'),
                      _buildLinearIcon(Icons.newspaper_outlined, 'NOTÍCIAS'),
                      _buildLinearIcon(Icons.forum_outlined, 'ENTREVISTAS'),
                      _buildLinearIcon(Icons.favorite_border, 'CONTRIBUA'),
                      _buildLinearIcon(Icons.schedule_outlined, 'PROGRAMAÇÃO'),
                      _buildLinearIcon(Icons.grid_view_outlined, 'DEPARTAMENTOS'),
                      _buildLinearIcon(Icons.menu_book_outlined, 'BÍBLIA', destination: const BibliaInPeace()),
                      _buildLinearIcon(Icons.volunteer_activism_outlined, 'ORAÇÕES', destination: const OracaoInPeace()),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Indicador de Scroll
                const Icon(Icons.keyboard_arrow_down, color: Colors.white54, size: 30),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinearIcon(IconData icon, String label, {Widget? destination}) {
    return InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 9,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
