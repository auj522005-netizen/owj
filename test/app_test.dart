import 'package:flutter_test/flutter_test.dart';
import 'package:owj/core/constants.dart';

void main() {
  group('AppConstants', () {
    test('app name should be correct', () {
      expect(AppConstants.appName, 'أوج');
    });

    test('app name en should be correct', () {
      expect(AppConstants.appNameEn, 'OWJ');
    });

    test('max chat messages should be an int', () {
      expect(AppConstants.maxChatMessages, isA<int>());
    });

    test('character prompts should not be empty', () {
      expect(AppConstants.characterPrompts, isNotEmpty);
    });

    test('character names should match prompts keys', () {
      expect(
        AppConstants.characterNames.keys.toSet(),
        equals(AppConstants.characterPrompts.keys.toSet()),
      );
    });

    test('firebase config should be set', () {
      expect(AppConstants.firebaseApiKey, isNotEmpty);
      expect(AppConstants.firebaseProjectId, isNotEmpty);
    });

    test('routes should be defined', () {
      expect(AppConstants.routeSplash, '/');
      expect(AppConstants.routeHome, '/home');
      expect(AppConstants.routeChat, '/chat');
    });
  });
}
