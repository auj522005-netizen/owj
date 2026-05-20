import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';
import '../core/constants.dart';

/// Service for interacting with multiple AI providers
class AIService {
  AIService._();

  /// Generate response using Gemini
  static Future<String> generateWithGemini(
    String prompt, {
    String? systemPrompt,
    List<Map<String, String>>? history,
  }) async {
    try {
      final model = GenerativeModel(
        model: AppConstants.geminiModel,
        apiKey: AppConstants.geminiApiKey,
        systemInstruction: Content.text(systemPrompt ?? AppConstants.characterPrompts['default']!),
      );

      final chat = model.startChat(history: _convertHistory(history));

      final response = await chat.sendMessage(Content.text(prompt));
      return response.text ?? 'مفيش رد متاح حاليًا، حاول تاني.';
    } catch (e) {
      return 'حصل خطأ: ${e.toString()}';
    }
  }

  /// Generate response using Groq
  static Future<String> generateWithGroq(
    String prompt, {
    String? systemPrompt,
    List<Map<String, String>>? history,
  }) async {
    try {
      final messages = <Map<String, String>>[
        {'role': 'system', 'content': systemPrompt ?? AppConstants.characterPrompts['default']!},
        if (history != null) ...history,
        {'role': 'user', 'content': prompt},
      ];

      final response = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${AppConstants.groqApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': AppConstants.groqModel,
          'messages': messages,
          'max_tokens': AppConstants.maxTokens,
          'temperature': AppConstants.temperature,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ?? 'مفيش رد متاح.';
      }
      return 'حصل خطأ في الاتصال: ${response.statusCode}';
    } catch (e) {
      return 'حصل خطأ: ${e.toString()}';
    }
  }

  /// Generate response using Cerebras
  static Future<String> generateWithCerebras(
    String prompt, {
    String? systemPrompt,
    List<Map<String, String>>? history,
  }) async {
    try {
      final messages = <Map<String, String>>[
        {'role': 'system', 'content': systemPrompt ?? AppConstants.characterPrompts['default']!},
        if (history != null) ...history,
        {'role': 'user', 'content': prompt},
      ];

      final response = await http.post(
        Uri.parse('https://api.cerebras.ai/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${AppConstants.cerebrasApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': AppConstants.cerebrasModel,
          'messages': messages,
          'max_tokens': AppConstants.maxTokens,
          'temperature': AppConstants.temperature,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ?? 'مفيش رد متاح.';
      }
      return 'حصل خطأ في الاتصال: ${response.statusCode}';
    } catch (e) {
      return 'حصل خطأ: ${e.toString()}';
    }
  }

  /// Generate response using OpenRouter
  static Future<String> generateWithOpenRouter(
    String prompt, {
    String? systemPrompt,
    List<Map<String, String>>? history,
  }) async {
    try {
      final messages = <Map<String, String>>[
        {'role': 'system', 'content': systemPrompt ?? AppConstants.characterPrompts['default']!},
        if (history != null) ...history,
        {'role': 'user', 'content': prompt},
      ];

      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${AppConstants.openRouterApiKey}',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://owj.app',
        },
        body: jsonEncode({
          'model': 'meta-llama/llama-3.3-70b-instruct',
          'messages': messages,
          'max_tokens': AppConstants.maxTokens,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ?? 'مفيش رد متاح.';
      }
      return 'حصل خطأ في الاتصال: ${response.statusCode}';
    } catch (e) {
      return 'حصل خطأ: ${e.toString()}';
    }
  }

  /// Generate response using BigModel (ZhipuAI)
  static Future<String> generateWithBigModel(
    String prompt, {
    String? systemPrompt,
    List<Map<String, String>>? history,
  }) async {
    try {
      final messages = <Map<String, String>>[
        {'role': 'system', 'content': systemPrompt ?? AppConstants.characterPrompts['default']!},
        if (history != null) ...history,
        {'role': 'user', 'content': prompt},
      ];

      final response = await http.post(
        Uri.parse('https://open.bigmodel.cn/api/paas/v4/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${AppConstants.bigModelApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'glm-4-flash',
          'messages': messages,
          'max_tokens': AppConstants.maxTokens,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ?? 'مفيش رد متاح.';
      }
      return 'حصل خطأ في الاتصال: ${response.statusCode}';
    } catch (e) {
      return 'حصل خطأ: ${e.toString()}';
    }
  }

  /// Unified generate method - routes to the selected provider
  static Future<String> generate(
    String prompt, {
    String provider = 'gemini',
    String? systemPrompt,
    List<Map<String, String>>? history,
  }) async {
    switch (provider) {
      case 'gemini':
        return generateWithGemini(prompt, systemPrompt: systemPrompt, history: history);
      case 'groq':
        return generateWithGroq(prompt, systemPrompt: systemPrompt, history: history);
      case 'cerebras':
        return generateWithCerebras(prompt, systemPrompt: systemPrompt, history: history);
      case 'openrouter':
        return generateWithOpenRouter(prompt, systemPrompt: systemPrompt, history: history);
      case 'bigmodel':
        return generateWithBigModel(prompt, systemPrompt: systemPrompt, history: history);
      default:
        return generateWithGemini(prompt, systemPrompt: systemPrompt, history: history);
    }
  }

  static List<Content> _convertHistory(List<Map<String, String>>? history) {
    if (history == null) return [];
    return history.map((msg) {
      if (msg['role'] == 'user') {
        return Content.text(msg['content'] ?? '');
      }
      return Content.model([TextPart(msg['content'] ?? '')]);
    }).toList();
  }
}
