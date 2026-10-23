import 'package:flutter/material.dart';
import 'cores.dart';
import 'tela_entrada.dart';

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final borda = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFDDDBD5)),
    );

    return MaterialApp(
      title: 'Simulador de Investimentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: corPrincipal,
        scaffoldBackgroundColor: corFundo,
        appBarTheme: const AppBarTheme(
          backgroundColor: corFundo,
          foregroundColor: corPrincipal,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: corPrincipal),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFE4E2DC)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: borda,
          enabledBorder: borda,
          focusedBorder: borda.copyWith(
              borderSide: const BorderSide(color: corPrincipal, width: 1.5)),
          errorBorder: borda.copyWith(
              borderSide: BorderSide(color: Colors.red.shade700)),
          focusedErrorBorder: borda.copyWith(
              borderSide: BorderSide(color: Colors.red.shade700, width: 1.5)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: corPrincipal,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: corPrincipal,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      home: const TelaEntrada(),
    );
  }
}