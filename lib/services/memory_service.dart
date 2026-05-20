import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

/// Service for Mem0 memory management
class MemoryService {
  MemoryService._();

  static const String _baseUrl = 'https://api.mem0.ai/v1';

  /// Add a memory for the user
  static Future<bool> addMemory(String userId, String content) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/memories/'),
        headers: {
          'Authorization': 'Token ${AppConstants.mem0ApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'messages': [{'role': 'user', 'content': content}],
          'user_id': userId,
        }),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  /// Get all memories for the user
  static Future<List<MemoryData>> getMemories(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/memories/?user_id=$userId'),
        headers: {
          'Authorization': 'Token ${AppConstants.mem0ApiKey}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = <MemoryData>[];
        for (final item in data['results'] as List? ?? []) {
          results.add(MemoryData(
            id: item['id'] as String? ?? '',
            content: item['memory'] as String? ?? '',
            createdAt: item['created_at'] as String? ?? '',
          ));
        }
        return results;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Delete a memory
  static Future<bool> deleteMemory(String memoryId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/memories/$memoryId/'),
        headers: {
          'Authorization': 'Token ${AppConstants.mem0ApiKey}',
        },
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      return false;
    }
  }

  /// Search memories
  static Future<List<MemoryData>> searchMemories(String userId, String query) async {
    try {
      final response = await http.post(
        Uri.parse('$_betaUrl/memories/search/'),
        headers: {
          'Authorization': 'Token ${AppConstants.mem0ApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'query': query,
          'user_id': userId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = <MemoryData>[];
        for (final item in data as List? ?? []) {
          results.add(MemoryData(
            id: item['id'] as String? ?? '',
            content: item['memory'] as String? ?? '',
            createdAt: item['created_at'] as String? ?? '',
          ));
        }
        return results;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static const String _betaUrl = 'https://api.mem0.ai/v1';
}

class MemoryData {
  final String id;
  final String content;
  final String createdAt;

  MemoryData({
    required this.id,
    required this.content,
    required this.createdAt,
  });
}
