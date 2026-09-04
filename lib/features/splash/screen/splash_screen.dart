import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_app/features/main/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MainScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 0.90,
              child: const Icon(
                Icons.flight,
                size: 90,
                color: Color(0xFF4F46E5),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFF06B6D4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.public,
                size: 75,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Travel App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172554),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Explore the world with ease',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
            ),

            const SizedBox(height: 35),

            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Color(0xFF4F46E5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}