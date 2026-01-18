import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// EGet Premium Fintech Theme
/// Clean, modern, elegant design with orange accent
class AppTheme {
    AppTheme._();

    // Light Theme
    static ThemeData get lightTheme {
          return ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.light,
                  colorScheme: const ColorScheme.light(
                            primary: AppColors.primary,
                            secondary: AppColors.secondary,
                            surface: AppColors.surface,
                            error: AppColors.error,
                            onPrimary: Colors.white,
                            onSecondary: Colors.white,
                            onSurface: AppColors.textPrimary,
                            onError: Colors.white,
                          ),
                  scaffoldBackgroundColor: AppColors.background,
                  appBarTheme: AppBarTheme(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.textPrimary,
                            centerTitle: true,
                            titleTextStyle: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                          ),
                  textTheme: _textTheme,
                  cardTheme: CardTheme(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                            color: Colors.white,
                            surfaceTintColor: Colors.transparent,
                          ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                            style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                        shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(16),
                                                    ),
                                        textStyle: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                      ),
                          ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                            style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColors.primary,
                                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                        shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(16),
                                                    ),
                                        side: const BorderSide(color: AppColors.primary, width: 1.5),
                                        textStyle: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                      ),
                          ),
                  inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: AppColors.inputBackground,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                            enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                            focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(color: AppColors.primary, width: 2),
                                      ),
                            errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
                                      ),
                            hintStyle: GoogleFonts.inter(
                                        color: AppColors.textTertiary,
                                        fontSize: 16,
                                      ),
                            labelStyle: GoogleFonts.inter(
                                        color: AppColors.textSecondary,
                                        fontSize: 16,
                                      ),
                          ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                          ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                            backgroundColor: Colors.white,
                            selectedItemColor: AppColors.primary,
                            unselectedItemColor: AppColors.textTertiary,
                            type: BottomNavigationBarType.fixed,
                            elevation: 8,
                          ),
                  dividerTheme: const DividerThemeData(
                            color: AppColors.divider,
                            thickness: 1,
                            space: 1,
                          ),
                );
    }

    // Dark Theme
    static ThemeData get darkTheme {
          return ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.dark,
                  colorScheme: const ColorScheme.dark(
                            primary: AppColors.primary,
                            secondary: AppColors.secondary,
                            surface: AppColors.darkSurface,
                            error: AppColors.error,
                            onPrimary: Colors.white,
                            onSecondary: Colors.white,
                            onSurface: Colors.white,
                            onError: Colors.white,
                          ),
                  scaffoldBackgroundColor: AppColors.darkBackground,
                );
    }

    // Text Theme
    static TextTheme get _textTheme {
          return TextTheme(
                  displayLarge: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                  displayMedium: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                  displaySmall: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                  headlineLarge: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                  headlineMedium: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                  headlineSmall: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                  titleLarge: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                  titleMedium: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                  titleSmall: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                  bodyLarge: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: AppColors.textPrimary,
                          ),
                  bodyMedium: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: AppColors.textSecondary,
                          ),
                  bodySmall: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.textTertiary,
                          ),
                  labelLarge: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                  labelMedium: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                  labelSmall: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                          ),
                );
    }
}
