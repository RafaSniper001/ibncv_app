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
    // Vídeo de fundo em loop (Substituir pelo seu vídeo oficial se necessário)
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://assets.mixkit.co/videos/preview/mixkit-clouds-and-blue-sky-background-27471-large.mp4'),
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
          // 1. Vídeo de Fundo 100%
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.isInitialized ? _controller.value.size.width : 100,
                height: _controller.value.isInitialized ? _controller.value.size.height : 100,
                child: _controller.value.isInitialized ? VideoPlayer(_controller) : Container(color: Colors.black),
              ),
            ),
          ),
          // 2. Camada de Neon Bloom (Efeito de partículas/luz ao fundo)
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  const Color(0xFFFF9800).withOpacity(0.1),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          // 3. Interface Principal (Estilo Neon)
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
                const SizedBox(height: 10),
                // Logo IBNCV com Brilho Neon (Bíblia com Chama)
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Brilho Fundo
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF9800).withOpacity(0.3),
                                blurRadius: 60,
                                spreadRadius: 10,
                              ),
                              BoxShadow(
                                color: const Color(0xFF00BFFF).withOpacity(0.2), // Brilho azul de fundo
                                blurRadius: 50,
                                spreadRadius: -10,
                              ),
                            ],
                          ),
                        ),
                        // Ícone da Bíblia (Abaixo, servindo de base)
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Icon(Icons.menu_book, size: 80, color: const Color(0xFF00BFFF), shadows: [
                            const Shadow(color: Color(0xFF00BFFF), blurRadius: 20),
                            const Shadow(color: Colors.white, blurRadius: 5),
                          ]),
                        ),
                        // Chama subindo saindo da bíblia (Acima)
                        Positioned(
                          top: 0,
                          child: Icon(Icons.local_fire_department, size: 90, color: const Color(0xFFFF5722), shadows: [
                            const Shadow(color: Color(0xFFFF9800), blurRadius: 30),
                            const Shadow(color: Color(0xFFFFEB3B), blurRadius: 15),
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'IBN CRISTO VIVE',
                      style: GoogleFonts.cinzel(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 3,
                        shadows: [
                          const Shadow(color: Colors.white54, blurRadius: 10),
                        ],
                      ),
                    ),
                    Text(
                      'UMA IGREJA ACOLHEDORA',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: const Color(0xFFFFEB3B),
                        letterSpacing: 6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Grelha de Ícones 3D Tecnológicos (Neon)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.9,
                    physics: const NeverScrollableScrollPhysics(), // Evitar scroll duplo
                    children: [
                      _buildNeonIconButton(Icons.church, 'IGREJA', const Color(0xFFD32F2F)),
                      _buildNeonIconButton(Icons.video_library, 'CULTO', const Color(0xFFFF9800)),
                      _buildNeonIconButton(Icons.campaign, 'AVISOS', const Color(0xFFFFEB3B)),
                      _buildNeonIconButton(Icons.menu_book, 'BÍBLIA', const Color(0xFF00BFFF), destination: const BibliaScreen()),
                      _buildNeonIconButton(Icons.volunteer_activism, 'ORAÇÕES', const Color(0xFFD32F2F), destination: const OracaoScreen()),
                      _buildNeonIconButton(Icons.favorite, 'CONTRIBUA', const Color(0xFFFF9800), destination: const ContribuaScreen()),
                      _buildNeonIconButton(Icons.event, 'EVENTOS', const Color(0xFFFFEB3B)),
                      _buildNeonIconButton(Icons.groups, 'DEPARTAMENTOS', const Color(0xFF00BFFF)),
                      _buildNeonIconButton(Icons.more_horiz, 'MAIS', Colors.white54),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white54, size: 30),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeonIconButton(IconData icon, String label, Color glowColor, {Widget? destination}) {
    return GestureDetector(
      onTap: () {
        if (destination != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: glowColor.withOpacity(0.4),
                  width: 1.2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 36, color: glowColor, shadows: [
                    Shadow(color: glowColor, blurRadius: 10),
                  ]),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 9,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
