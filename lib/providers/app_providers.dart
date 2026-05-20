import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

/// Provider for SharedPreferences
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// Provider for selected AI provider
final selectedProviderProvider = StateNotifierProvider<SelectedProviderNotifier, String>((ref) {
  return SelectedProviderNotifier();
});

class SelectedProviderNotifier extends StateNotifier<String> {
  SelectedProviderNotifier() : super('gemini');

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
final selectedCharacterProvider = StateNotifierProvider<SelectedCharacterNotifier, String>((ref) {
  return SelectedCharacterNotifier();
});

class SelectedCharacterNotifier extends StateNotifier<String> {
  SelectedCharacterNotifier() : super('default');

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
final ttsEnabledProvider = StateNotifierProvider<TTSEnabledNotifier, bool>((ref) {
  return TTSEnabledNotifier();
});

class TTSEnabledNotifier extends StateNotifier<bool> {
  TTSEnabledNotifier() : super(false);

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
final fontSizeProvider = StateNotifierProvider<FontSizeNotifier, double>((ref) {
  return FontSizeNotifier();
});

class FontSizeNotifier extends StateNotifier<double> {
  FontSizeNotifier() : super(16.0);

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
final onboardingDoneProvider = StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  return OnboardingNotifier();
});

class OnboardingNotifier extends StateNotifier<bool> {
  OnboardingNotifier() : super(false);

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
