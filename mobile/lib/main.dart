import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const NovaApp());

class NovaApp extends StatelessWidget {
  const NovaApp({super.key});
  @override
  Widget build(BuildContext c) =>
      MaterialApp(title: 'Nova AI', debugShowCheckedModeBanner: false, theme: buildTheme(), home: const SplashScreen());
}
