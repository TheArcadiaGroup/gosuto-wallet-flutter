import 'package:flutter/material.dart';
import 'package:gosuto/themes/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      fontFamily: 'Manrope',
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(12), // Creates border
            color: const Color(0xFF725DFF)),
      ),
      colorScheme: ColorScheme(
          primary: Colors.white,
          primaryContainer: Colors.white,
          secondary: Colors.white,
          secondaryContainer: Colors.white,
          surface: const Color(0xFF383B62).withOpacity(0.3),
          background: const Color(0xFFFF8266),
          error: const Color(0xFFFF6666),
          onPrimary: Colors.white.withOpacity(0.5),
          onSecondary: Colors.black12,
          onSurface: const Color(0xFFBDBDBE),
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
          onTertiary: const Color(0xFF4F4F4F),
          onTertiaryContainer: const Color(0xFFF1F1F1),
          tertiaryContainer: const Color(0xFFA9A9A9),
          onPrimaryContainer: Colors.white),
      textTheme: TextTheme(
          headline1: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          headline4: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          headline2: const TextStyle(
              fontSize: 14,
              color: Color(0xFF725DFF),
              fontWeight: FontWeight.bold),
          headline3: const TextStyle(
              fontSize: 12,
              color: Color(0xFF70CF98),
              fontWeight: FontWeight.bold),
          headline5: const TextStyle(
              fontSize: 12,
              color: Color(0xFFFF6666),
              fontWeight: FontWeight.bold),
          bodyText1: const TextStyle(fontSize: 14, color: Color(0xFF4F4F4F)),
          bodyText2: TextStyle(
              fontSize: 14, color: const Color(0xFF383B62).withOpacity(0.3)),
          subtitle1: const TextStyle(fontSize: 14, color: Color(0xFFBDBDBE)),
          subtitle2: const TextStyle(fontSize: 12, color: Color(0xFFA9A9A9))));

  static final darkTheme = ThemeData(
      fontFamily: 'Manrope',
      primaryColor: const Color(0xFF363B46),
      scaffoldBackgroundColor: const Color(0xFF363B46),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF2A2F3C)),
      tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Creates border
              color: const Color(0xFF725DFF))),
      colorScheme: const ColorScheme(
          primary: Color(0xFF363B46),
          primaryContainer: Color(0xFF363B46),
          secondary: Color(0xFF313642),
          secondaryContainer: Color(0xFF2A2F3C),
          surface: Colors.white,
          background: Color(0xFFFF8266),
          error: Color(0xFFFF6666),
          onPrimary: Colors.white,
          onSecondary: Colors.white30,
          onSurface: Color(0xFFBDBDBE),
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.dark,
          onTertiary: Colors.white,
          onTertiaryContainer: Colors.white24,
          tertiaryContainer: Colors.white,
          onPrimaryContainer: Colors.white10),
      textTheme: TextTheme(
          headline1: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          headline4: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          headline2: const TextStyle(
              fontSize: 14,
              color: Color(0xFF725DFF),
              fontWeight: FontWeight.bold),
          headline3: const TextStyle(
              fontSize: 10,
              color: Color(0xFF70CF98),
              fontWeight: FontWeight.bold),
          headline5: const TextStyle(
              fontSize: 12,
              color: Color(0xFFFF6666),
              fontWeight: FontWeight.bold),
          bodyText1: const TextStyle(fontSize: 14, color: Colors.white),
          bodyText2:
          TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.5)),
          subtitle1: const TextStyle(fontSize: 14, color: Color(0xFFBDBDBE)),
          subtitle2: const TextStyle(fontSize: 12, color: Color(0xFFA9A9A9))));
}
