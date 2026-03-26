import 'dart:ui';
import 'package:flutter/material.dart';

class NeonCard extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final double blurRadius;
  final VoidCallback? onTap;

  const NeonCard({
    super.key,
    required this.child,
    this.glowColor = const Color(0xFF00BFFF), // Azul elétrico padrão
    this.blurRadius = 15.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.3),
              blurRadius: blurRadius,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: glowColor.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
