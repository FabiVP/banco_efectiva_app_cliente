import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: EfectivaColors.azulCorporativo,
      scaffoldBackgroundColor: EfectivaColors.grisFondo,
      colorScheme: ColorScheme.fromSeed(
        seedColor: EfectivaColors.azulCorporativo,
        primary: EfectivaColors.azulCorporativo,
        secondary: EfectivaColors.verdeExito,
        surface: EfectivaColors.blanco,
        error: EfectivaColors.rojoError,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: EfectivaColors.negroTexto,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: EfectivaColors.negroTexto,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: EfectivaColors.negroTexto,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: EfectivaColors.negroTexto,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: EfectivaColors.negroTexto,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: EfectivaColors.grisTexto,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: EfectivaColors.grisMedio,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: EfectivaColors.blanco,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: EfectivaColors.azulCorporativo,
        foregroundColor: EfectivaColors.blanco,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: EfectivaColors.blanco,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: EfectivaColors.azulCorporativo,
          foregroundColor: EfectivaColors.blanco,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: EfectivaColors.azulCorporativo,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: const BorderSide(color: EfectivaColors.azulCorporativo),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: EfectivaColors.blanco,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: EfectivaColors.grisBorde),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: EfectivaColors.grisBorde),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: EfectivaColors.azulCorporativo, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: EfectivaColors.rojoError),
        ),
        labelStyle: GoogleFonts.inter(
          color: EfectivaColors.grisTexto,
          fontSize: 14,
        ),
        hintStyle: GoogleFonts.inter(
          color: EfectivaColors.grisMedio,
          fontSize: 14,
        ),
      ),
      cardTheme: CardThemeData(
        color: EfectivaColors.blanco,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: EfectivaColors.blanco,
        selectedItemColor: EfectivaColors.azulCorporativo,
        unselectedItemColor: EfectivaColors.grisMedio,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: EfectivaColors.grisBorde,
        thickness: 1,
        space: 0,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return EfectivaColors.azulCorporativo;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(EfectivaColors.blanco),
        side: const BorderSide(color: EfectivaColors.grisMedio, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return EfectivaColors.azulCorporativo;
          }
          return EfectivaColors.grisMedio;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return EfectivaColors.azulSuave;
          }
          return EfectivaColors.grisClaro;
        }),
      ),
    );
  }
}
