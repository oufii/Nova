import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _i = 0;
  @override
  Widget build(BuildContext c) => Scaffold(
        body: IndexedStack(index: _i, children: [HomeScreen(onOpenChat: () => setState(() => _i = 1)), const ChatScreen(), const SettingsScreen()]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _i,
          onDestinationSelected: (v) => setState(() => _i = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.auto_awesome), label: 'Chat'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
          ],
        ),
      );
}
