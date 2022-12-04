import 'package:flutter/material.dart';

class AppStyle {

  static ThemeData getTheme(){

    return ThemeData().copyWith(
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,

      textTheme: const TextTheme(
        headline2: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600
        ),
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