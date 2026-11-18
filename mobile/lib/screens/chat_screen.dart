import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/locator.dart';
import '../core/theme.dart';
import '../models/models.dart';
import '../widgets/common.dart';
import '../widgets/state_views.dart';

class ChatScreen extends StatefulWidget {
  final Conversation? conversation;
  const ChatScreen({super.key, this.conversation});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _c = TextEditingController();
  final _scroll = ScrollController();
  late Conversation conv = widget.conversation ?? Conversation.empty();
  bool loading = false;
  String? error;

  void _down() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scroll.hasClients) _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      });

  Future<void> _send([bool retry = false]) async {
    final t = _c.text.trim();
    if (loading || (!retry && t.isEmpty)) return;
    setState(() {
      if (!retry) { conv.messages.add(Message.user(t)); _c.clear(); }
      loading = true;
      error = null;
    });
    _down();
    try {
      final r = await aiService.sendMessage(conv.id, conv.messages);
      setState(() => conv.messages.add(Message.ai(r)));
    } catch (_) {
      setState(() => error = 'Could not get a response.');
    } finally {
      if (mounted) setState(() => loading = false);
      _down();
    }
  }

  void _regen() {
    if (conv.messages.isNotEmpty && conv.messages.last.role == Role.ai) {
      setState(() => conv.messages.removeLast());
      _send(true);
    }
  }

  void _newChat() => setState(() { conv = Conversation.empty(); error = null; });

  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text(conv.title), actions: [IconButton(icon: const Icon(Icons.add_comment_outlined), onPressed: _newChat)]),
        drawer: Drawer(
          backgroundColor: AppColors.surface,
          child: SafeArea(
            child: FutureBuilder<List<Conversation>>(
              future: chatRepository.getConversations(),
              builder: (_, s) => ListView(children: [
                const ListTile(title: Text('Chat history', style: TextStyle(fontWeight: FontWeight.w800))),
                for (final cv in s.data ?? <Conversation>[])
                  ListTile(leading: const Icon(Icons.chat_bubble_outline), title: Text(cv.title), onTap: () { Navigator.pop(c); setState(() => conv = cv); }),
              ]),
            ),
          ),
        ),
        body: Column(children: [
          Expanded(
            child: conv.messages.isEmpty
                ? StateView.empty(message: 'Say hello to start the conversation.')
                : ListView(controller: _scroll, padding: const EdgeInsets.all(16), children: [
                    for (var i = 0; i < conv.messages.length; i++) _bubble(conv.messages[i], i == conv.messages.length - 1),
                    if (loading) const Align(alignment: Alignment.centerLeft, child: TypingDots()),
                    if (error != null) StateView.error(message: error!, onRetry: () => _send(true)),
                  ]),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 10),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: _c,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                        hintText: 'Message Nova...', filled: true, fillColor: AppColors.card,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none)),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(onPressed: loading ? null : () => _send(), icon: const Icon(Icons.send)),
              ]),
            ),
          ),
        ]),
      );

  Widget _bubble(Message m, bool last) {
    final me = m.role == Role.user;
    return Align(
      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
        decoration: BoxDecoration(
            color: me ? null : AppColors.card,
            gradient: me ? AppColors.gradient : null,
            borderRadius: BorderRadius.circular(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(m.text),
          if (!me)
            Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.copy, size: 18),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: m.text));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied')));
                  }),
              if (last) IconButton(visualDensity: VisualDensity.compact, icon: const Icon(Icons.refresh, size: 18), onPressed: _regen),
            ]),
        ]),
      ),
    );
  }
}
