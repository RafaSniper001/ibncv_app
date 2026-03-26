import 'package:flutter/material.dart';

class IconeFuturista extends StatelessWidget {
  final String texto;
  final IconData icone;
  final Color corIcone;
  final VoidCallback? onTap;

  const IconeFuturista({
    Key? key,
    required this.texto,
    required this.icone,
    this.corIcone = Colors.white,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.orange.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: Icon(
                  icone,
                  size: 40,
                  color: corIcone,
                  shadows: [
                    Shadow(color: corIcone, blurRadius: 15),
                    const Shadow(color: Colors.white54, blurRadius: 5),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            texto,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
