import 'dart:ui';

class AppColors {
  // Primary Colors
  static const primaryYellow = Color(0xFFFFD700);
  static const primaryPurple = Color(0xFF8B5CF6);

  // Background Colors
  static const backgroundOverlay = Color(0x4D000000);
  static const cardBackground = Color(0x33000000);
  static const selectedCardBackground = Color(0x66000000);

  // Text Colors
  static const primaryText = Color(0xFFFFFFFF);
  static const secondaryText = Color(0xB3FFFFFF);
  static const captionText = Color(0x80FFFFFF);

  // Border Colors
  static const defaultBorder = Color(0x33FFFFFF);
  static const selectedBorder = Color(0xCCFFD700);
  static const highlightedBorder = Color(0x998B5CF6);

  // Accent Colors
  static const notificationBlue = Color(0xFF007AFF);
  static const successGreen = Color(0xFF34C759);
  static const warningOrange = Color(0xFFFF9500);
  static const errorRed = Color(0xFFFF3B30);

  // Gradient Colors
  static List<Color> get backgroundGradient => [
    const Color(0x4D000000),
    const Color(0x1A000000),
    const Color(0x66000000),
    const Color(0xCC000000),
  ];

  static List<double> get backgroundGradientStops => [0.0, 0.3, 0.7, 1.0];
}