import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../core/theme.dart';
import '../providers/app_providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = const [
    OnboardingPage(
      icon: '🤖',
      title: 'أهلاً بيك في أوج',
      description: 'مرشدك الذكي الشخصي اللي بيتكلم بالعربي المصري. اسأل أي سؤال وهيرد عليك بأسلوب مصري أصيل.',
      gradientColors: [Color(0xFF6C63FF), Color(0xFF00D9FF)],
    ),
    OnboardingPage(
      icon: '🎭',
      title: 'شخصيات متنوعة',
      description: 'اختار الشخصية اللي تناسبك - مدرس، دكتور، شيف، مبرمج، صاحب، أو شاعر. كل شخصية لها أسلوبها الخاص.',
      gradientColors: [Color(0xFFE91E63), Color(0xFFFF9800)],
    ),
    OnboardingPage(
      icon: '🧠',
      title: 'ذاكرة ذكية',
      description: 'أوج بيتذكر محادثاتك وبيفهم تفضيلاتك. كل ما تتكلم معاه أكتر، هيبقى أحسن.',
      gradientColors: [Color(0xFF4CAF50), Color(0xFF00BCD4)],
    ),
    OnboardingPage(
      icon: '🔍',
      title: 'بحث ويب مباشر',
      description: 'اسأل عن أي حاجة وأوج هيبحث على النت ويجيبلك أحدث المعلومات.',
      gradientColors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppTheme.bgDark),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () => _completeOnboarding(),
                  child: const Text(
                    'تخطي',
                    style: TextStyle(color: AppTheme.textHint, fontFamily: 'Cairo'),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) => _buildPage(_pages[index]),
                ),
              ),
              const SizedBox(height: 20),
              SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppTheme.primaryColor,
                  dotColor: AppTheme.textHint.withValues(alpha: 0.3),
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 4,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        _completeOnboarding();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentPage == _pages.length - 1
                          ? AppTheme.primaryColor
                          : AppTheme.bgCard,
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'يلا نبدأ!' : 'التالي',
                      style: const TextStyle(fontSize: 18, fontFamily: 'Cairo'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: page.gradientColors),
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: page.gradientColors[0].withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Text(page.icon, style: const TextStyle(fontSize: 64)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
              fontFamily: 'Cairo',
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() {
    ref.read(onboardingDoneProvider.notifier).complete();
    context.go('/home');
  }
}

class OnboardingPage {
  final String icon;
  final String title;
  final String description;
  final List<Color> gradientColors;

  const OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradientColors,
  });
}
