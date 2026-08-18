import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/presentation/auth_screens.dart';
import '../features/shell/presentation/main_shell.dart';
import 'app_scope.dart';
import 'app_state.dart';

class FoodPleaseApp extends StatefulWidget {
  const FoodPleaseApp({super.key});
  @override
  State<FoodPleaseApp> createState() => _App();
}

class _App extends State<FoodPleaseApp> {
  final state = AppState();
  @override
  Widget build(BuildContext c) => Scope(
    state: state,
    child: AnimatedBuilder(
      animation: state,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodPlease',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: canvas,
          colorScheme: ColorScheme.fromSeed(
            seedColor: orange,
            primary: orange,
            secondary: charcoal,
            surface: Colors.white,
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontWeight: FontWeight.w800,
              letterSpacing: -.7,
            ),
            headlineMedium: TextStyle(fontWeight: FontWeight.w700),
            titleLarge: TextStyle(fontWeight: FontWeight.w700),
            titleMedium: TextStyle(fontWeight: FontWeight.w700),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: Color(0xFFECEFF1)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 17,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFEEEEEE)),
            ),
          ),
        ),
        home: state.logged ? const Shell() : const Login(),
      ),
    ),
  );
}
