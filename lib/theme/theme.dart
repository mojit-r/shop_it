import 'package:flutter/material.dart';

// ThemeProvider Class
class ThemeProvider extends ChangeNotifier {
  IconData _themeIcon = Icons.nights_stay_rounded;
  ThemeMode _customThemeMode = ThemeMode.light;

  IconData get themeIcon => _themeIcon;
  ThemeMode get customThemeMode => _customThemeMode;

  void themeChanger() {
    if (_customThemeMode == ThemeMode.light) {
      _themeIcon = Icons.sunny;
      _customThemeMode = ThemeMode.dark;
      notifyListeners();
    } else {
      _themeIcon = Icons.nights_stay_rounded;
      _customThemeMode = ThemeMode.light;
      notifyListeners();
    }
  }
}

// lightColorScheme variable
final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.indigo,
  brightness: Brightness.light,
);

// darkColorScheme variable
final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.indigo,
  brightness: Brightness.dark,
);

// Light Theme data
ThemeData lightMode = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,

  // Text Theme still used for the isInCart Item text and SnackBar Text
  textTheme: TextTheme(
    labelSmall: TextStyle(
      fontSize: 14,
      color: lightColorScheme.onPrimaryContainer,
    ),
    bodyMedium: TextStyle(color: lightColorScheme.onPrimaryContainer),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: lightColorScheme.onPrimaryContainer,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
    ),
  ),

  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color.fromARGB(230, 2, 238, 113),
  ),
);

// Dark Thmee data
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,

  // Text Theme still used for the isInCart Item text and SnackBar Text
  textTheme: TextTheme(
    labelSmall: TextStyle(fontSize: 14, color: darkColorScheme.onPrimary),
    bodyLarge: TextStyle(color: darkColorScheme.onPrimary),
    bodyMedium: TextStyle(color: darkColorScheme.onPrimary),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 5,
      backgroundColor: darkColorScheme.primary,
      foregroundColor: darkColorScheme.onPrimary,
    ),
  ),

  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color.fromARGB(230, 2, 238, 113),
  ),

  cardTheme: CardThemeData(color: darkColorScheme.onSecondary),
);
