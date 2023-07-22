import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData get darkTheme => ThemeData.from(
        useMaterial3: true,
        // TODO: we can customize the color scheme here
        colorScheme: const ColorScheme.dark(primary: Colors.redAccent),
      );
}
