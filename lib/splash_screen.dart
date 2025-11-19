import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  late final Animation<double> _scaleIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _fadeIn = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleIn = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    // Navigasi ke HomePage setelah 2.5 detik
    Timer(const Duration(milliseconds: 2700), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomePage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // efek shimmer pada logo
  Widget _buildShimmerLogo() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double angle = _controller.value * 2 * math.pi;
        return Stack(
          alignment: Alignment.center,
          children: [
            // Logo utama
            ClipOval(
              child: Container(
                width: 140,
                height: 140,
                color: Colors.white,
                child: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover),
              ),
            ),

            // Efek kilau berputar
            Transform.rotate(
              angle: angle,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    startAngle: 0,
                    endAngle: math.pi * 2,
                    colors: [
                      Colors.white.withOpacity(0.0),
                      const Color.fromARGB(255, 1, 8, 20).withOpacity(0.4),
                      const Color.fromARGB(255, 243, 241, 241).withOpacity(0.0),
                    ],
                    stops: const [0.2, 0.5, 0.8],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D47A1), // biru tua elegan
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: ScaleTransition(
            scale: _scaleIn,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildShimmerLogo(),
                const SizedBox(height: 25),
                Text(
                  'UTB FUTSAL',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 6,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'KARYA : HASBI • FAJAR • AHMAD',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
