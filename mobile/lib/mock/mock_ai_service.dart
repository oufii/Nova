import '../models/models.dart';
import '../services/ai_service.dart';

class MockAIService implements AIService {
  @override
  Future<String> sendMessage(String conversationId, List<Message> history) async {
    await Future.delayed(const Duration(milliseconds: 1400));
    final last = history.last.text.toLowerCase();
    if (last.contains('error')) throw Exception('mock error'); // test the error state
    return 'AI response placeholder.\n\nYou said: "${history.last.text}"';
  }
}
