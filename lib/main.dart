import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme.dart';
import 'core/constants.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/characters_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/memory_screen.dart';
import 'screens/about_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: OWJApp()));
}

class OWJApp extends ConsumerWidget {
  const OWJApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: AppConstants.routeSplash,
      routes: [
        GoRoute(
          path: AppConstants.routeSplash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppConstants.routeOnboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: AppConstants.routeHome,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppConstants.routeChat,
          builder: (context, state) => ChatScreen(
            initialMessage: state.extra as String?,
          ),
        ),
        GoRoute(
          path: AppConstants.routeCharacters,
          builder: (context, state) => const CharactersScreen(),
        ),
        GoRoute(
          path: AppConstants.routeSettings,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: AppConstants.routeMemory,
          builder: (context, state) => const MemoryScreen(),
        ),
        GoRoute(
          path: AppConstants.routeAbout,
          builder: (context, state) => const AboutScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
      locale: const Locale('ar', 'EG'),
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
    );
  }
}
