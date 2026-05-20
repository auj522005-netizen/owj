class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final String? characterId;

  ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.characterId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'isUser': isUser,
        'timestamp': timestamp.toIso8601String(),
        'characterId': characterId,
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'] as String,
        content: json['content'] as String,
        isUser: json['isUser'] as bool,
        timestamp: DateTime.parse(json['timestamp'] as String),
        characterId: json['characterId'] as String?,
      );
}

class AIProvider {
  final String id;
  final String name;
  final String description;
  final bool isAvailable;

  const AIProvider({
    required this.id,
    required this.name,
    required this.description,
    this.isAvailable = true,
  });
}

class MemoryItem {
  final String id;
  final String content;
  final DateTime timestamp;
  final String category;

  MemoryItem({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
        'category': category,
      };

  factory MemoryItem.fromJson(Map<String, dynamic> json) => MemoryItem(
        id: json['id'] as String,
        content: json['content'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        category: json['category'] as String,
      );
}
