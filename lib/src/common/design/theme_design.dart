import 'package:material_ui/material_ui.dart';

class ThemeDesign {
  static const Color darkCanvas = Color(0xFF0D1117);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkBorder = Color(0xFF30363D);
  static const Color darkText = Color(0xFFE6EDF3);
  static const Color darkMuted = Color(0xFF8D96A0);
  static const Color darkAccent = Color(0xFF2F81F7);

  static const Color lightCanvas = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF6F8FA);
  static const Color lightBorder = Color(0xFFD0D7DE);
  static const Color lightText = Color(0xFF1F2328);
  static const Color lightMuted = Color(0xFF656D76);
  static const Color lightAccent = Color(0xFF0969DA);

  static const Color success = Color(0xFF238636);

  static ThemeData get light => _build(
        brightness: Brightness.light,
        canvas: lightCanvas,
        surface: lightSurface,
        border: lightBorder,
        text: lightText,
        muted: lightMuted,
        accent: lightAccent,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        canvas: darkCanvas,
        surface: darkSurface,
        border: darkBorder,
        text: darkText,
        muted: darkMuted,
        accent: darkAccent,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color canvas,
    required Color surface,
    required Color border,
    required Color text,
    required Color muted,
    required Color accent,
  }) {
    final borderSide = BorderSide(color: border);
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: canvas,
      dividerColor: border,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accent,
        onPrimary: Colors.white,
        secondary: success,
        onSecondary: Colors.white,
        error: const Color(0xFFCF222E),
        onError: Colors.white,
        surface: canvas,
        onSurface: text,
        surfaceContainer: surface,
        outline: border,
        onSurfaceVariant: muted,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: text,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: Border(bottom: borderSide),
        titleTextStyle: TextStyle(
          color: text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: canvas,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: borderSide,
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: borderSide,
        ),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(color: accent, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(color: text),
        bodySmall: TextStyle(color: muted, fontSize: 12),
      ),
    );
  }
}