import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

/// Service for Tavily web search integration
class SearchService {
  SearchService._();

  /// Search the web using Tavily API
  static Future<List<SearchResult>> search(String query, {int maxResults = 5}) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.tavily.com/search'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'api_key': AppConstants.tavilyApiKey,
          'query': query,
          'max_results': maxResults,
          'search_depth': 'basic',
          'include_answer': true,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = <SearchResult>[];

        if (data['answer'] != null) {
          results.add(SearchResult(
            title: 'إجابة سريعة',
            content: data['answer'] as String,
            url: '',
          ));
        }

        if (data['results'] != null) {
          for (final item in data['results'] as List) {
            results.add(SearchResult(
              title: item['title'] as String? ?? '',
              content: item['content'] as String? ?? '',
              url: item['url'] as String? ?? '',
            ));
          }
        }

        return results;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

class SearchResult {
  final String title;
  final String content;
  final String url;

  SearchResult({
    required this.title,
    required this.content,
    required this.url,
  });
}
