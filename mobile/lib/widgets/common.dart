import 'package:flutter/material.dart';
import '../core/theme.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const GradientButton(this.label, {super.key, required this.onPressed});
  @override
  Widget build(BuildContext c) => InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          height: 54,
          decoration: BoxDecoration(gradient: AppColors.gradient, borderRadius: BorderRadius.circular(16)),
          child: Center(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
        ),
      );
}

class Logo extends StatelessWidget {
  final double size;
  const Logo({super.key, this.size = 72});
  @override
  Widget build(BuildContext c) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: AppColors.gradient,
          borderRadius: BorderRadius.circular(size * .3),
          boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(.5), blurRadius: 30)],
        ),
        child: Icon(Icons.auto_awesome, size: size * .5),
      );
}

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const AppCard({super.key, required this.child, this.onTap});
  @override
  Widget build(BuildContext c) => Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
            borderRadius: BorderRadius.circular(18), onTap: onTap, child: Padding(padding: const EdgeInsets.all(16), child: child)),
      );
}

class TypingDots extends StatefulWidget {
  const TypingDots({super.key});
  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots> with SingleTickerProviderStateMixin {
  late final AnimationController _a = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat();
  @override
  void dispose() { _a.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext c) => AnimatedBuilder(
        animation: _a,
        builder: (_, __) => Row(mainAxisSize: MainAxisSize.min, children: List.generate(3, (i) {
          final v = ((_a.value + i * .2) % 1);
          return Container(
              margin: const EdgeInsets.all(3),
              width: 8,
              height: 8,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accent.withOpacity(.3 + .7 * (1 - v))));
        })),
      );
}
