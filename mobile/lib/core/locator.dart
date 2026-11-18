import '../mock/mock_ai_service.dart';
import '../mock/mock_data.dart';
import '../repositories/chat_repository.dart';
import '../services/ai_service.dart';

/// Single place to swap mock implementations for real ones.
AIService aiService = MockAIService(); // TODO: RealAIService()
ChatRepository chatRepository = MockChatRepository(); // TODO: real repository
