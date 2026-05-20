import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../providers/app_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await ref.read(selectedProviderProvider.notifier).loadSaved();
    await ref.read(selectedCharacterProvider.notifier).loadSaved();
    await ref.read(ttsEnabledProvider.notifier).loadSaved();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCharacter = ref.watch(selectedCharacterProvider);
    final characterName = AppConstants.characterNames[selectedCharacter] ?? 'أوج';
    final characterIcon = AppConstants.characterIcons[selectedCharacter] ?? '🤖';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppTheme.bgDark),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildHeader(characterName, characterIcon),
              ),
              SliverToBoxAdapter(
                child: _buildQuickActions(),
              ),
              SliverToBoxAdapter(
                child: _buildCharacterSelector(),
              ),
              SliverToBoxAdapter(
                child: _buildRecentChats(),
              ),
              SliverToBoxAdapter(
                child: _buildFeatures(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/chat'),
        icon: const Icon(Icons.chat_bubble_outline),
        label: const Text('محادثة جديدة', style: TextStyle(fontFamily: 'Cairo')),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader(String characterName, String characterIcon) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(child: Text(characterIcon, style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'أهلاً بيك',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  'شكل $characterName',
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'أسئلة سريعة',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildQuickChip('إيه أخبار مصر؟', Icons.public),
              _buildQuickChip('وصفة كبسة', Icons.restaurant),
              _buildQuickChip('شرح Flutter', Icons.code),
              _buildQuickChip('نصيحة صحية', Icons.favorite),
              _buildQuickChip('اكتبلي شعر', Icons.edit),
              _buildQuickChip('ترجملي جملة', Icons.translate),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickChip(String label, IconData icon) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: AppTheme.primaryColor),
      label: Text(label, style: const TextStyle(fontFamily: 'Cairo', fontSize: 13)),
      onPressed: () => context.push('/chat', extra: label),
      backgroundColor: AppTheme.bgCard,
      side: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
    );
  }

  Widget _buildCharacterSelector() {
    final selectedCharacter = ref.watch(selectedCharacterProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الشخصيات',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              TextButton(
                onPressed: () => context.push('/characters'),
                child: const Text('عرض الكل', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.characterNames.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final key = AppConstants.characterNames.keys.elementAt(index);
                final name = AppConstants.characterNames[key]!;
                final icon = AppConstants.characterIcons[key]!;
                final isSelected = key == selectedCharacter;

                return GestureDetector(
                  onTap: () => ref.read(selectedCharacterProvider.notifier).setCharacter(key),
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryColor.withValues(alpha: 0.2) : AppTheme.bgCard,
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? Border.all(color: AppTheme.primaryColor, width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(icon, style: const TextStyle(fontSize: 28)),
                        const SizedBox(height: 4),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Cairo',
                            color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentChats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'محادثات حديثة',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppTheme.bgCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.chat_bubble_outline, size: 48, color: AppTheme.textHint),
                SizedBox(height: 12),
                Text(
                  'مفيش محادثات لسه',
                  style: TextStyle(color: AppTheme.textHint, fontFamily: 'Cairo'),
                ),
                SizedBox(height: 4),
                Text(
                  'ابدأ محادثة جديدة ونتكلم!',
                  style: TextStyle(color: AppTheme.textHint, fontSize: 12, fontFamily: 'Cairo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الميزات',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              _buildFeatureCard('بحث ويب', Icons.search, 'ابحث على النت مباشرة', const [Color(0xFF2196F3), Color(0xFF00BCD4)]),
              _buildFeatureCard('ذاكرة ذكية', Icons.psychology, 'يتذكر تفضيلاتك', const [Color(0xFF4CAF50), Color(0xFF8BC34A)]),
              _buildFeatureCard('صوت طبيعي', Icons.record_voice_over, 'يرد عليك بالصوت', const [Color(0xFFFF9800), Color(0xFFFFC107)]),
              _buildFeatureCard('موفري AI', Icons.cloud, '5 مزودين مختلفين', const [Color(0xFF9C27B0), Color(0xFFE91E63)]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, String subtitle, List<Color> colors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors[0].withValues(alpha: 0.2), colors[1].withValues(alpha: 0.1)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors[0].withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colors[0], size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Cairo',
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppTheme.textHint,
                fontSize: 11,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() => _currentIndex = index);
        switch (index) {
          case 1:
            context.push('/characters');
          case 2:
            context.push('/memory');
          case 3:
            context.push('/settings');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الشخصيات'),
        BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'الذاكرة'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
      ],
    );
  }
}
