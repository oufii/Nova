import '../models/models.dart';
import '../repositories/chat_repository.dart';

class MockChatRepository implements ChatRepository {
  @override
  User get currentUser => const User(id: '1', name: 'Alex', email: 'alex@example.com');

  @override
  Future<List<Conversation>> getConversations() async => [
        Conversation(id: 'c1', title: 'Plan my week', messages: [
          Message.user('Help me plan my week.'),
          Message.ai('AI response placeholder. Here is a sample plan.')
        ]),
        Conversation(id: 'c2', title: 'Explain quantum computing', messages: [
          Message.user('Explain quantum computing simply.'),
          Message.ai('AI response placeholder.')
        ]),
        Conversation(id: 'c3', title: 'Write an email', messages: [Message.user('Draft a polite email.')]),
      ];
}
