# OWJ - أوج

> مرشدك الذكي الشخصي بالعربي المصري

## عن التطبيق

أوج هو مساعد ذكي شخصي بيتكلم بالعربي المصري، مصمم خصيصاً للمستخدم المصري. التطبيق بيدعم شوية مزودين ذكاء اصطناعي وشخصيات متنوعة.

## الميزات

- 🤖 **ذكاء اصطناعي متعدد**: 5 مزودين AI (Gemini, Groq, Cerebras, OpenRouter, BigModel)
- 🎭 **شخصيات متنوعة**: 8 شخصيات بأسلوب مصري (مدرس، دكتور، شيف، مبرمج، ...)
- 🧠 **ذاكرة ذكية**: Mem0 integration لتذكر تفضيلاتك
- 🔊 **صوت طبيعي**: ElevenLabs TTS لتحويل النص لكلام
- 🔍 **بحث ويب**: Tavily search للبحث المباشر
- 🌍 **عربي مصري**: مصمم خصيصاً بالعربي المصري

## التقنيات

- Flutter 3.44+
- Dart 3.8+
- Riverpod for state management
- GoRouter for navigation
- Firebase Analytics & Crashlytics

## البناء

```bash
flutter pub get
flutter analyze
flutter build apk --release
```

## Codemagic

التطبيق جاهز للبناء على Codemagic. شوف `codemagic.yaml` للتفاصيل.
