import '../models/models.dart';

/// Contract for any AI provider. Implement this in RealAIService later.
abstract class AIService {
  Future<String> sendMessage(String conversationId, List<Message> history);
}
