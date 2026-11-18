import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/common.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext c) => Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TweenAnimationBuilder<double>(
                tween: Tween(begin: .6, end: 1),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutBack,
                builder: (_, v, w) => Transform.scale(scale: v, child: w),
                child: const Logo(size: 96)),
            const SizedBox(height: 20),
            const Text('Nova AI', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: 1)),
            const SizedBox(height: 28),
            const SizedBox(width: 120, child: LinearProgressIndicator(color: AppColors.accent, backgroundColor: AppColors.card)),
          ]),
        ),
      );
}
