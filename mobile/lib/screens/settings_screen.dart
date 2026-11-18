import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/models.dart';
import 'auth_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final s = UserSettings();
  @override
  Widget build(BuildContext c) => SafeArea(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          const Padding(padding: EdgeInsets.all(8), child: Text('Settings', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800))),
          _t(Icons.person_outline, 'Account', 'Profile and email'),
          _t(Icons.palette_outlined, 'Appearance', 'Dark (default)'),
          SwitchListTile(
              secondary: const Icon(Icons.notifications_none),
              title: const Text('Notifications'),
              value: s.notifications,
              onChanged: (v) => setState(() => s.notifications = v)),
          _t(Icons.language, 'Language', s.language),
          _t(Icons.lock_outline, 'Privacy', 'Data and permissions'),
          _t(Icons.info_outline, 'About', 'Nova AI v1.0.0'),
          ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: const Text('Logout', style: TextStyle(color: AppColors.error)),
              onTap: () => Navigator.pushAndRemoveUntil(c, MaterialPageRoute(builder: (_) => const AuthScreen(isLogin: true)), (_) => false)),
        ]),
      );

  Widget _t(IconData i, String t, String sub) =>
      ListTile(leading: Icon(i), title: Text(t), subtitle: Text(sub, style: const TextStyle(color: AppColors.muted)), trailing: const Icon(Icons.chevron_right));
}
