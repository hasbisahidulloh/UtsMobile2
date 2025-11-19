import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const UTBFutsalApp());
}

class UTBFutsalApp extends StatelessWidget {
  const UTBFutsalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'utbfutsal_apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xFFF7F7FB),
      ),
      home: const SplashScreen(),
    );
  }
}
