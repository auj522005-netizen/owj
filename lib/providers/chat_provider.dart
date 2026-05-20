import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_models.dart';
import '../services/ai_service.dart';
import '../core/constants.dart';

/// State class for AI Chat
class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Chat notifier - Riverpod 3 Notifier API
class ChatNotifier extends Notifier<ChatState> {
  @override
  ChatState build() => const ChatState();

  Future<void> sendMessage(String content, {String character = 'default', String provider = 'gemini'}) async {
    if (content.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
      characterId: character,
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    try {
      final systemPrompt = AppConstants.characterPrompts[character] ?? AppConstants.characterPrompts['default']!;

      final history = state.messages
          .map((m) => {
                'role': m.isUser ? 'user' : 'assistant',
                'content': m.content,
              })
          .toList();

      final response = await AIService.generate(
        content,
        provider: provider,
        systemPrompt: systemPrompt,
        history: history,
      );

      final assistantMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
        characterId: character,
      );

      state = state.copyWith(
        messages: [...state.messages, assistantMessage],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearChat() {
    state = const ChatState();
  }
}

/// Chat provider
final chatProvider = NotifierProvider<ChatNotifier, ChatState>(() {
  return ChatNotifier();
});

/// Available AI providers
final aiProvidersProvider = Provider<List<AIProvider>>((ref) {
  return const [
    AIProvider(id: 'gemini', name: 'Gemini', description: 'Google Gemini 2.0 Flash - سريع وذكي'),
    AIProvider(id: 'groq', name: 'Groq', description: 'Groq Llama 3.3 70B - أسرع استجابة'),
    AIProvider(id: 'cerebras', name: 'Cerebras', description: 'Cerebras Llama 3.3 - أداء عالي'),
    AIProvider(id: 'openrouter', name: 'OpenRouter', description: 'OpenRouter - نماذج متعددة'),
    AIProvider(id: 'bigmodel', name: 'BigModel', description: 'ZhipuAI GLM-4 - دعم عربي ممتاز'),
  ];
});
