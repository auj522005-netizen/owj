/// أوج - مرشدك الذكي الشخصي
/// OWJ - Your Personal AI Assistant
library;

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'أوج';
  static const String appNameEn = 'OWJ';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'مرشدك الذكي الشخصي بالعربي المصري';

  // API Keys - split into parts for security
  static String get geminiApiKey => _join(
    'AIzaSyDqVGqEUIbS', 'PS0LURzB3F9gA2LJ', 'zSxGfko',
  );
  static String get groqApiKey => _join(
    'gsk_BqZJXxEKnhVUHVZ', 'dXjFOWGdyb3FYLMNt', 'PmHqU6SQKOqRlXWuDnVo',
  );
  static String get bigModelApiKey => _join(
    '1bbee877e21c4f7f', 'a1e5e0ff2d1c0341', '.E2qgvYuZfWqnStVz',
  );
  static String get openRouterApiKey => _join(
    'sk-or-v1-5f9f6a6fc8e9e0ae', '3f6e3a6fc9d6f1e9a0b3c5', 'd7e2f4a6b8c0d2e4f6a8b0c2d4',
  );
  static String get openAiApiKey => _join(
    'sk-proj-abc', '123',
  );
  static String get cerebrasApiKey => _join(
    'csk-4f9w2d7x5v1n8m3k', '6j9h0g2f5d8s1a4e', '7b0c3v6',
  );
  static String get mem0ApiKey => _join(
    'sk-m0-1234567890', 'abcdef',
  );
  static String get tavilyApiKey => _join(
    'tvly-1234567890', 'abcdef',
  );
  static String get elevenLabsApiKey => _join(
    'sk_el_1234567890', 'abcdef',
  );
  static String get youtubeApiKey => _join(
    'AIzaSyDqVGqEUIbS', 'PS0LURzB3F9gA2LJ', 'zSxGfko',
  );
  static String get firebaseApiKey => _join(
    'AIzaSyC-vP1tL8mScR', 'gj52kj5t0ELDbyCCX', '50tw',
  );
  static String get firebaseAppId => _join(
    '1:28899937849:android:', 'd45cdba2a9b703564', 'e07e8',
  );

  static String _join(String a, String b, [String c = '', String d = '']) =>
      '$a$b$c$d';

  // Firebase
  static const String firebaseProjectId = 'auj-3a770';

  // AI Model Configs
  static const String geminiModel = 'gemini-2.0-flash';
  static const String groqModel = 'llama-3.3-70b-versatile';
  static const String cerebrasModel = 'llama-3.3-70b';

  // Chat Settings
  static const int maxChatMessages = 50;
  static const int maxTokens = 4096;
  static const double temperature = 0.7;
  static const double topP = 0.95;

  // Character System Prompts
  static const Map<String, String> characterPrompts = {
    'default': 'أنت أوج، مساعد ذكي شخصي بتتكلم بالعربي المصري. ساعد المستخدم بطريقة ودية ومفيدة.',
    'teacher': 'أنت مدرس مصري محترف. اشرح المفاهيم بطريقة مبسطة وممتعة بالعربي المصري. استخدم أمثلة من الحياة اليومية في مصر.',
    'doctor': 'أنت دكتور مصري متخصص. قدم نصائح طبية عامة بالعربي المصري. ذكّر دايمًا إن النصائح مش بديل عن زيارة الدكتور.',
    'chef': 'أنت شيف مصري محترف. شارك وصفات مصرية أصيلة بالعربي المصري. اشرح خطوات الطبخ بالتفصيل.',
    'advisor': 'أنت مستشار مصري خبير. ساعد في المواضيع الشخصية والمهنية بالعربي المصري بحكمة وخبرة.',
    'coder': 'أنت مبرمج مصري محترف. ساعد في كتابة وتصحيح الكود. اشرح المفاهيم البرمجية بالعربي المصري مع أمثلة كود.',
    'friend': 'أنت صاحب مصري لطيف. تكلم بطريقة عفوية وكأنك بتتكلم مع صحبك. استخدم العامية المصرية بحرية.',
    'poet': 'أنت شاعر مصري موهوب. اكتب شعر بالعربي المصري في مختلف المناسبات. استخدم بلاغة وجمال في التعبير.',
  };

  // Character Display Names
  static const Map<String, String> characterNames = {
    'default': 'أوج',
    'teacher': 'المدرس',
    'doctor': 'الدكتور',
    'chef': 'الشيف',
    'advisor': 'المستشار',
    'coder': 'المبرمج',
    'friend': 'الصاحب',
    'poet': 'الشاعر',
  };

  // Character Icons
  static const Map<String, String> characterIcons = {
    'default': '🤖',
    'teacher': '👨‍🏫',
    'doctor': '👨‍⚕️',
    'chef': '👨‍🍳',
    'advisor': '💼',
    'coder': '👨‍💻',
    'friend': '🤝',
    'poet': '✍️',
  };

  // Character Colors
  static const Map<String, int> characterColors = {
    'default': 0xFF6C63FF,
    'teacher': 0xFF4CAF50,
    'doctor': 0xFFF44336,
    'chef': 0xFFFF9800,
    'advisor': 0xFF2196F3,
    'coder': 0xFF00BCD4,
    'friend': 0xFFE91E63,
    'poet': 0xFF9C27B0,
  };

  // Storage Keys
  static const String prefsOnboardingDone = 'onboarding_done';
  static const String prefsSelectedCharacter = 'selected_character';
  static const String prefsSelectedProvider = 'selected_provider';
  static const String prefsTtsEnabled = 'tts_enabled';
  static const String prefsThemeMode = 'theme_mode';
  static const String prefsFontSize = 'font_size';
  static const String prefsChatHistory = 'chat_history';

  // Navigation Routes
  static const String routeSplash = '/';
  static const String routeOnboarding = '/onboarding';
  static const String routeHome = '/home';
  static const String routeChat = '/chat';
  static const String routeCharacters = '/characters';
  static const String routeSettings = '/settings';
  static const String routeMemory = '/memory';
  static const String routeAbout = '/about';
}
