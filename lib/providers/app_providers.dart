import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

/// Provider for SharedPreferences
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// Provider for selected AI provider
final selectedProviderProvider = NotifierProvider<SelectedProviderNotifier, String>(() {
  return SelectedProviderNotifier();
});

class SelectedProviderNotifier extends Notifier<String> {
  @override
  String build() => 'gemini';

  Future<void> loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString(AppConstants.prefsSelectedProvider) ?? 'gemini';
  }

  Future<void> setProvider(String provider) async {
    state = provider;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefsSelectedProvider, provider);
  }
}

/// Provider for selected character
final selectedCharacterProvider = NotifierProvider<SelectedCharacterNotifier, String>(() {
  return SelectedCharacterNotifier();
});

class SelectedCharacterNotifier extends Notifier<String> {
  @override
  String build() => 'default';

  Future<void> loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString(AppConstants.prefsSelectedCharacter) ?? 'default';
  }

  Future<void> setCharacter(String character) async {
    state = character;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefsSelectedCharacter, character);
  }
}

/// Provider for TTS enabled state
final ttsEnabledProvider = NotifierProvider<TTSEnabledNotifier, bool>(() {
  return TTSEnabledNotifier();
});

class TTSEnabledNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(AppConstants.prefsTtsEnabled) ?? false;
  }

  Future<void> toggle() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsTtsEnabled, state);
  }
}

/// Provider for font size
final fontSizeProvider = NotifierProvider<FontSizeNotifier, double>(() {
  return FontSizeNotifier();
});

class FontSizeNotifier extends Notifier<double> {
  @override
  double build() => 16.0;

  Future<void> loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getDouble(AppConstants.prefsFontSize) ?? 16.0;
  }

  Future<void> setFontSize(double size) async {
    state = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(AppConstants.prefsFontSize, size);
  }
}

/// Provider for onboarding status
final onboardingDoneProvider = NotifierProvider<OnboardingNotifier, bool>(() {
  return OnboardingNotifier();
});

class OnboardingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(AppConstants.prefsOnboardingDone) ?? false;
  }

  Future<void> complete() async {
    state = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsOnboardingDone, true);
  }
}
