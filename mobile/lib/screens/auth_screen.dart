import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/common.dart';
import 'home_shell.dart';

/// Login + Register share one screen. Auth is MOCK: any input passes.
class AuthScreen extends StatefulWidget {
  final bool isLogin;
  const AuthScreen({super.key, required this.isLogin});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool _login = widget.isLogin;
  bool _hide = true;

  InputDecoration _dec(String l, IconData i) => InputDecoration(
      labelText: l,
      prefixIcon: Icon(i),
      filled: true,
      fillColor: AppColors.card,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none));

  @override
  Widget build(BuildContext c) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(24), children: [
            const SizedBox(height: 24),
            const Align(alignment: Alignment.centerLeft, child: Logo(size: 56)),
            const SizedBox(height: 24),
            Text(_login ? 'Welcome back' : 'Create account', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 28),
            if (!_login) ...[TextField(decoration: _dec('Name', Icons.person_outline)), const SizedBox(height: 14)],
            TextField(decoration: _dec('Email', Icons.mail_outline), keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 14),
            TextField(
                obscureText: _hide,
                decoration: _dec('Password', Icons.lock_outline).copyWith(
                    suffixIcon: IconButton(icon: Icon(_hide ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _hide = !_hide)))),
            const SizedBox(height: 24),
            GradientButton(_login ? 'Log in' : 'Register',
                onPressed: () => Navigator.pushAndRemoveUntil(c, MaterialPageRoute(builder: (_) => const HomeShell()), (_) => false)),
            TextButton(
                onPressed: () => setState(() => _login = !_login),
                child: Text(_login ? 'No account? Register' : 'Have an account? Log in')),
          ]),
        ),
      );
}
