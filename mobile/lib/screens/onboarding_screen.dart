import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/common.dart';
import 'auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _p = PageController();
  int _i = 0;
  static const _pages = [
    (Icons.chat_bubble_outline, 'Ask anything', 'Chat naturally with your AI workspace.'),
    (Icons.bolt, 'Work faster', 'Quick actions for writing, planning and learning.'),
    (Icons.history, 'Pick up anywhere', 'Your conversations, always organized.'),
  ];

  void _next() {
    if (_i == _pages.length - 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthScreen(isLogin: true)));
    } else {
      _p.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext c) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              Expanded(
                child: PageView(
                  controller: _p,
                  onPageChanged: (i) => setState(() => _i = i),
                  children: [
                    for (final p in _pages)
                      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        ShaderMask(
                            shaderCallback: (r) => AppColors.gradient.createShader(r), child: Icon(p.$1, size: 120, color: Colors.white)),
                        const SizedBox(height: 32),
                        Text(p.$2, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 10),
                        Text(p.$3, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted, fontSize: 16)),
                      ]),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (var k = 0; k < _pages.length; k++)
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.all(4),
                      width: k == _i ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(color: k == _i ? AppColors.accent : AppColors.card, borderRadius: BorderRadius.circular(8))),
              ]),
              const SizedBox(height: 20),
              GradientButton(_i == _pages.length - 1 ? 'Get started' : 'Next', onPressed: _next),
            ]),
          ),
        ),
      );
}
