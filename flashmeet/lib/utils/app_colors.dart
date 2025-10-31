import 'package:flutter/material.dart';

class AppColors {
  // Palette fournie : 262322 - cf5c36 - eee5e9 - 7c7c7c - 4062bb
  // Couleurs principales FlashMeet
  static const Color primaryLight = Color(0xFF4062BB); // Bleu
  static const Color primaryDark = Color(0xFF262322); // Très foncé

  // Couleurs secondaires / accent
  static const Color accent = Color(0xFFCF5C36); // Orange/Corail
  static const Color accentLight = Color(0xFFEEE5E9); // Rose très pâle

  // Couleurs sémantiques
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Couleurs neutres - Mode clair
  static const Color backgroundLight = Color(0xFFEEE5E9);
  static const Color surfaceLight = Colors.white;
  static const Color textPrimaryLight = Color(0xFF262322);
  static const Color textSecondaryLight = Color(0xFF7C7C7C);
  static const Color dividerLight = Color(0xFFE0DCE0);

  // Couleurs neutres - Mode sombre
  static const Color backgroundDark = Color(0xFF262322);
  static const Color surfaceDark = Color(0xFF2E2A2B);
  static const Color textPrimaryDark = Color(0xFFEEE5E9);
  static const Color textSecondaryDark = Color(0xFF7C7C7C);
  static const Color dividerDark = Color(0xFF3A3737);

  // Couleurs spécifiques FlashMeet
  static const Color flashGradientStart = primaryLight;
  static const Color flashGradientEnd = accent;

  // Gradient pour les éléments importants
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [flashGradientStart, flashGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
