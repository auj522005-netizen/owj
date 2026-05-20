import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عن أوج'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // App Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'أوج',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              AppConstants.appDescription,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'الإصدار ${AppConstants.appVersion}',
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textHint,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 32),

            // Features
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الميزات الرئيسية',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem('🤖', 'ذكاء اصطناعي متعدد', '5 مزودين AI مختلفين'),
                  _buildFeatureItem('🎭', 'شخصيات متنوعة', '8 شخصيات بأسلوب مصري'),
                  _buildFeatureItem('🧠', 'ذاكرة ذكية', 'يتذكر تفضيلاتك واهتماماتك'),
                  _buildFeatureItem('🔊', 'صوت طبيعي', 'تحويل النص لكلام مصري'),
                  _buildFeatureItem('🔍', 'بحث ويب', 'معلومات محدثة من النت'),
                  _buildFeatureItem('🌍', 'عربي مصري', 'مصمم خصيصاً للمصريين'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tech Stack
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'التقنيات المستخدمة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildTechChip('Flutter'),
                      _buildTechChip('Dart'),
                      _buildTechChip('Riverpod'),
                      _buildTechChip('Gemini'),
                      _buildTechChip('Groq'),
                      _buildTechChip('Firebase'),
                      _buildTechChip('ElevenLabs'),
                      _buildTechChip('Mem0'),
                      _buildTechChip('Tavily'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'صُنع بحب للمستخدم المصري',
              style: TextStyle(
                color: AppTheme.textHint,
                fontSize: 14,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppTheme.textHint,
                    fontSize: 12,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 12, fontFamily: 'Cairo'),
      ),
      backgroundColor: AppTheme.bgInput,
      side: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
    );
  }
}
