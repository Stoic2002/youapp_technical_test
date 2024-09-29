import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFF62CDCB),
      Color(0xFF4599DB),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldenGradient = LinearGradient(
    colors: [
      Color(0xFF94783E),
      Color(0xFFF3EDA6),
      Color(0xFFF8FAE5),
      Color(0xFFFFE2BE),
      Color(0xFFD5BE88),
      Color(0xFFF8FAE5),
      Color(0xFFD5BE88)
    ],
  );

  static const RadialGradient backgroundGradient = RadialGradient(
    colors: [
      Color(0xFF1F4247),
      Color(0xFF0D1D23),
      Color(0xFF09141A),
    ],
    stops: [0.0, 0.2, 1.0],
    center: Alignment(1, -1),
    radius: 9.0,
  );

  static const Color mainBackground = Color(0xFF09141A);
  static const Color photoCard = Color(0xFF162329);
  static const Color card = Color(0xFF0E191F);
}
