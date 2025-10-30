import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales FlashMeet
  static const Color primaryLight = Color(0xFF6B4EFF); // Violet éclair
  static const Color primaryDark = Color(0xFF5A3FD9);

  // Couleurs secondaires
  static const Color accent = Color(0xFFFF6B9D); // Rose flash
  static const Color accentLight = Color(0xFFFFB3D4);

  // Couleurs sémantiques
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Couleurs neutres - Mode clair
  static const Color backgroundLight = Color(0xFFF8F9FE);
  static const Color surfaceLight = Colors.white;
  static const Color textPrimaryLight = Color(0xFF1A1A2E);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color dividerLight = Color(0xFFE5E7EB);

  // Couleurs neutres - Mode sombre
  static const Color backgroundDark = Color(0xFF0F0F23);
  static const Color surfaceDark = Color(0xFF1A1A2E);
  static const Color textPrimaryDark = Color(0xFFF8F9FE);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color dividerDark = Color(0xFF374151);

  // Couleurs spécifiques FlashMeet
  static const Color flashGradientStart = Color(0xFF6B4EFF);
  static const Color flashGradientEnd = Color(0xFFFF6B9D);

  // Gradient pour les éléments importants
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [flashGradientStart, flashGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

