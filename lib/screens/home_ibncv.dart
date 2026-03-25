import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'biblia_screen.dart';
import 'oracao_screen.dart';
import 'login_screen.dart';
import 'contribua_screen.dart';
import '../widgets/app_drawer.dart';

class HomeIBNCV extends StatefulWidget {
  const HomeIBNCV({super.key});

  @override
  State<HomeIBNCV> createState() => _HomeIBNCVState();
}

class _HomeIBNCVState extends State<HomeIBNCV> {
  late VideoPlayerController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://assets.mixkit.co/videos/preview/mixkit-fire-in-a-fireplace-1064-large.mp4')
    )..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
        setState(() {});
      }).catchError((error) {
        debugPrint("Erro ao carregar video: $error");
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
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: const AppDrawer(),
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
          // 2. Overlay Escuro Gradiente
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
          // 3. Conteúdo da Interface
          SafeArea(
            child: Column(
              children: [
                // Header: Menu e Perfil
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => _scaffoldKey.currentState?.openDrawer(),
                        child: const Icon(Icons.menu, color: Colors.white, size: 28),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                        child: const Icon(Icons.account_circle_outlined, color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                // Logótipo Oficial IBNCV (Bíblia com Chama)
                Column(
                  children: [
                    // Símbolo da Bíblia com Chama (Placeholder dinâmico)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.local_fire_department, size: 100, color: Color(0xFFFF9800)), // Chama (Laranja)
                        const Positioned(
                          bottom: 10,
                          child: Icon(Icons.menu_book, size: 60, color: Colors.white), // Bíblia (Branca)
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'IBN CRISTO VIVE',
                      style: GoogleFonts.cinzel(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'UMA IGREJA ACOLHEDORA',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: const Color(0xFFFFEB3B), // Amarelo para o slogan
                        letterSpacing: 4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
                // Grelha de Ícones Tecnológicos (Cores do Fogo)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                    children: [
                      _buildIbncvIcon(Icons.church, 'IGREJA', const Color(0xFFD32F2F)),
                      _buildIbncvIcon(Icons.video_library, 'CULTOS', const Color(0xFFFF9800)),
                      _buildIbncvIcon(Icons.campaign, 'AVISOS', const Color(0xFFFFEB3B)),
                      _buildIbncvIcon(Icons.menu_book, 'BÍBLIA', Colors.white, destination: const BibliaScreen()),
                      _buildIbncvIcon(Icons.volunteer_activism, 'ORAÇÕES', const Color(0xFFD32F2F), destination: const OracaoScreen()),
                      _buildIbncvIcon(Icons.favorite, 'CONTRIBUA', const Color(0xFFFF9800), destination: const ContribuaScreen()),
                      _buildIbncvIcon(Icons.event, 'EVENTOS', const Color(0xFFFFEB3B)),
                      _buildIbncvIcon(Icons.groups, 'DEPARTAMENTOS', Colors.white),
                      _buildIbncvIcon(Icons.more_horiz, 'MAIS', Colors.white54),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white54, size: 30),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIbncvIcon(IconData icon, String label, Color accentColor, {Widget? destination}) {
    return InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: accentColor),
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
