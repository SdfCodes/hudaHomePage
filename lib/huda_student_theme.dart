import 'package:flutter/material.dart';

class HudaStudentTheme {
  static const Color brand = Color(0xFFFFC226);
  static const Color accent = Color(0xFF53588A);
  static const Color ink = Color(0xFF2C3051);
  static const Color inkMuted = Color(0xFFA2A2A2);
  static const Color canvas = Color(0xFFF8F8F8);
  static const Color stroke = Color(0xFFD8DCFF);
  static const Color success = Color(0xFF12B76A);
  static const Color warning = Color(0xFFF79009);
  static const Color danger = Color(0xFFF04444);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: brand,
      primary: brand,
      secondary: accent,
      brightness: Brightness.light,
      surface: Colors.white,
      error: danger,
    );

    return _buildTheme(
      scheme: scheme,
      scaffoldColor: canvas,
      cardColor: Colors.white,
      textColor: ink,
      mutedTextColor: inkMuted,
      borderColor: stroke,
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: brand,
      primary: brand,
      secondary: accent,
      brightness: Brightness.dark,
      surface: const Color(0xFF1C2028),
      error: const Color(0xFFFF7A7A),
    );

    return _buildTheme(
      scheme: scheme,
      scaffoldColor: const Color(0xFF111318),
      cardColor: const Color(0xFF1C2028),
      textColor: const Color(0xFFF4F4F5),
      mutedTextColor: const Color(0xFFA1A7B3),
      borderColor: const Color(0xFF2E3440),
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme scheme,
    required Color scaffoldColor,
    required Color cardColor,
    required Color textColor,
    required Color mutedTextColor,
    required Color borderColor,
  }) {
    final baseTextTheme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Inter',
    ).textTheme;

    final textTheme = baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontSize: 42,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        fontSize: 16,
        color: textColor,
        fontFamilyFallback: const ['Noto Naskh Arabic'],
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        fontSize: 14,
        color: textColor,
        fontFamilyFallback: const ['Noto Naskh Arabic'],
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        fontSize: 12,
        color: mutedTextColor,
        fontFamilyFallback: const ['Noto Naskh Arabic'],
      ),
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: baseTextTheme.labelMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: accent,
      ),
      labelSmall: baseTextTheme.labelSmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );

    final rounded = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldColor,
      cardColor: cardColor,
      textTheme: textTheme,
      fontFamily: 'Inter',
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: textColor,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: borderColor.withValues(alpha: 0.12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        hintStyle: textTheme.bodyMedium?.copyWith(color: mutedTextColor),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: accent, width: 1.4),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardColor,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return textTheme.labelSmall?.copyWith(
            color: states.contains(WidgetState.selected)
                ? textColor
                : mutedTextColor,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          );
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: ink,
          elevation: 0,
          minimumSize: const Size.fromHeight(52),
          shape: rounded,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: cardColor,
          elevation: 0,
          minimumSize: const Size.fromHeight(52),
          side: BorderSide(color: borderColor),
          shape: rounded,
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          textStyle: textTheme.labelMedium,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: borderColor,
        space: 1,
        thickness: 1,
      ),
    );
  }
}
