import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

/// Service for ElevenLabs TTS integration
class TTSService {
  TTSService._();

  static const String _baseUrl = 'https://api.elevenlabs.io/v1';

  /// Get available voices
  static Future<List<VoiceData>> getVoices() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/voices'),
        headers: {
          'xi-api-key': AppConstants.elevenLabsApiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final voices = <VoiceData>[];
        for (final voice in data['voices'] as List? ?? []) {
          voices.add(VoiceData(
            id: voice['voice_id'] as String? ?? '',
            name: voice['name'] as String? ?? '',
            category: voice['category'] as String? ?? '',
          ));
        }
        return voices;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Convert text to speech
  static Future<Uint8List?> textToSpeech(String text, {String voiceId = '21m00Tcm4TlvDq8ikWAM'}) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/text-to-speech/$voiceId'),
        headers: {
          'xi-api-key': AppConstants.elevenLabsApiKey,
          'Content-Type': 'application/json',
          'Accept': 'audio/mpeg',
        },
        body: jsonEncode({
          'text': text,
          'model_id': 'eleven_multilingual_v2',
          'voice_settings': {
            'stability': 0.5,
            'similarity_boost': 0.75,
          },
        }),
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

class VoiceData {
  final String id;
  final String name;
  final String category;

  VoiceData({
    required this.id,
    required this.name,
    required this.category,
  });
}
