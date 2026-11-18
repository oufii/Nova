import '../models/models.dart';

abstract class ChatRepository {
  Future<List<Conversation>> getConversations();
  User get currentUser;
}
