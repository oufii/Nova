import 'package:flutter/material.dart';
import '../core/locator.dart';
import '../core/theme.dart';
import '../models/models.dart';
import '../widgets/common.dart';
import '../widgets/state_views.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onOpenChat;
  const HomeScreen({super.key, required this.onOpenChat});

  @override
  Widget build(BuildContext c) => SafeArea(
        child: ListView(padding: const EdgeInsets.all(20), children: [
          Text('Hello, ${chatRepository.currentUser.name}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
          const Text('What shall we work on?', style: TextStyle(color: AppColors.muted)),
          const SizedBox(height: 20),
          InkWell(
            onTap: onOpenChat,
            child: Ink(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: AppColors.gradient, borderRadius: BorderRadius.circular(22)),
              child: const Row(children: [
                Icon(Icons.auto_awesome, size: 32),
                SizedBox(width: 14),
                Expanded(child: Text('AI workspace\nStart a new conversation', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
                Icon(Icons.arrow_forward)
              ]),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Quick actions', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Wrap(spacing: 10, children: [
            for (final a in const [('Write', Icons.edit), ('Plan', Icons.event_note), ('Learn', Icons.school), ('Code', Icons.code)])
              ActionChip(avatar: Icon(a.$2, size: 18), label: Text(a.$1), onPressed: onOpenChat),
          ]),
          const SizedBox(height: 20),
          const Text('Recent conversations', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          FutureBuilder<List<Conversation>>(
            future: chatRepository.getConversations(),
            builder: (_, s) {
              if (s.connectionState != ConnectionState.done) return const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator()));
              if (s.hasError) return StateView.error();
              final list = s.data ?? [];
              if (list.isEmpty) return StateView.empty(message: 'No conversations yet.');
              return Column(children: [
                for (final cv in list)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppCard(
                      onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => ChatScreen(conversation: cv))),
                      child: Row(children: [const Icon(Icons.chat_bubble_outline, color: AppColors.accent), const SizedBox(width: 12), Expanded(child: Text(cv.title))]),
                    ),
                  ),
              ]);
            },
          ),
        ]),
      );
}
