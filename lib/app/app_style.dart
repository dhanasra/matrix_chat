import 'package:flutter/material.dart';

class AppStyle {

  static ThemeData getTheme(BuildContext context){
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,

      textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black.withOpacity(0.8),
      ),


      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),

    
      colorScheme: const ColorScheme.light()..copyWith(
        surfaceTint: Colors.amber
      ),

      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(0, 58)),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor: MaterialStateProperty.all(Colors.amber),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28)
            )
          ),
          elevation: MaterialStateProperty.all(0)
        )
      )
    );

  }
} 