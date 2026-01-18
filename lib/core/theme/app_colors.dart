import 'package:flutter/material.dart';

/// EGet App Colors - Fintech Premium Palette
/// Orange for CTAs, Navy/Graphite for headers, subtle greens/reds for entries/exits
class AppColors {
    AppColors._();

    // Primary Colors
    static const Color primary = Color(0xFFFF6B35);        // Orange - CTAs & highlights
    static const Color primaryLight = Color(0xFFFF8A5C);   // Light orange
    static const Color primaryDark = Color(0xFFE55A2B);    // Dark orange

    // Secondary Colors
    static const Color secondary = Color(0xFF1E3A5F);      // Navy blue - headers
    static const Color secondaryLight = Color(0xFF2C4A6E);
    static const Color secondaryDark = Color(0xFF152B47);

    // Background Colors
    static const Color background = Color(0xFFF8F9FA);     // Light gray background
    static const Color surface = Color(0xFFFFFFFF);        // White surface
    static const Color inputBackground = Color(0xFFF5F5F5); // Input field background

    // Dark Mode Colors
    static const Color darkBackground = Color(0xFF121212);
    static const Color darkSurface = Color(0xFF1E1E1E);

    // Text Colors
    static const Color textPrimary = Color(0xFF1A1A2E);    // Dark text
    static const Color textSecondary = Color(0xFF6B7280);  // Gray text
    static const Color textTertiary = Color(0xFF9CA3AF);   // Light gray text

    // Financial Colors
    static const Color income = Color(0xFF10B981);         // Green - entradas
    static const Color incomeLight = Color(0xFFD1FAE5);    // Light green background
    static const Color expense = Color(0xFFEF4444);        // Red - saídas
    static const Color expenseLight = Color(0xFFFEE2E2);   // Light red background

    // Status Colors
    static const Color success = Color(0xFF10B981);        // Green
    static const Color warning = Color(0xFFF59E0B);        // Amber
    static const Color error = Color(0xFFEF4444);          // Red
    static const Color info = Color(0xFF3B82F6);           // Blue

    // Alert Threshold Colors
    static const Color threshold80 = Color(0xFFF59E0B);    // 80% - warning yellow
    static const Color threshold90 = Color(0xFFEA580C);    // 90% - warning orange
    static const Color threshold100 = Color(0xFFDC2626);   // 100% - danger red

    // UI Colors
    static const Color divider = Color(0xFFE5E7EB);
    static const Color border = Color(0xFFD1D5DB);
    static const Color shadow = Color(0x1A000000);
    static const Color overlay = Color(0x80000000);

    // Card Colors
    static const Color cardBackground = Color(0xFFFFFFFF);
    static const Color cardShadow = Color(0x0A000000);

    // Gradient for progress bar
    static const LinearGradient progressGradient = LinearGradient(
          colors: [primary, primaryLight],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );

    // Card gradient
    static const LinearGradient cardGradient = LinearGradient(
          colors: [secondary, Color(0xFF2D4A6E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    // Methods to get threshold color based on percentage
    static Color getThresholdColor(double percentage) {
          if (percentage >= 100) return threshold100;
          if (percentage >= 90) return threshold90;
          if (percentage >= 80) return threshold80;
          return primary;
    }

    // Method to get transaction type color
    static Color getTransactionColor(bool isIncome) {
          return isIncome ? income : expense;
    }

    // Method to get transaction background color
    static Color getTransactionBackgroundColor(bool isIncome) {
          return isIncome ? incomeLight : expenseLight;
    }
}
