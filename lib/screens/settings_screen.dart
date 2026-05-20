import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../models/app_models.dart';
import '../providers/app_providers.dart';
import '../providers/chat_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedProvider = ref.watch(selectedProviderProvider);
    final ttsEnabled = ref.watch(ttsEnabledProvider);
    final fontSize = ref.watch(fontSizeProvider);
    final aiProviders = ref.watch(aiProvidersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // AI Provider Selection
          _buildSectionHeader('مزود الذكاء الاصطناعي'),
          const SizedBox(height: 8),
          ...aiProviders.map((provider) => _buildProviderTile(
                provider: provider,
                isSelected: provider.id == selectedProvider,
                onTap: () => ref.read(selectedProviderProvider.notifier).setProvider(provider.id),
              )),

          const SizedBox(height: 24),

          // Chat Settings
          _buildSectionHeader('إعدادات المحادثة'),
          const SizedBox(height: 8),
          _buildSliderTile(
            title: 'حجم الخط',
            value: fontSize,
            min: 12.0,
            max: 24.0,
            onChanged: (value) => ref.read(fontSizeProvider.notifier).setFontSize(value),
          ),

          const SizedBox(height: 24),

          // Voice Settings
          _buildSectionHeader('الصوت'),
          const SizedBox(height: 8),
          _buildSwitchTile(
            title: 'تحويل النص لصوت',
            subtitle: 'يقرأ الردود بصوت عالٍ',
            value: ttsEnabled,
            onChanged: () => ref.read(ttsEnabledProvider.notifier).toggle(),
          ),

          const SizedBox(height: 24),

          // Data Management
          _buildSectionHeader('إدارة البيانات'),
          const SizedBox(height: 8),
          _buildActionTile(
            title: 'مسح المحادثات',
            subtitle: 'حذف كل سجل المحادثات',
            icon: Icons.delete_outline,
            onTap: () => _showClearChatDialog(),
          ),
          _buildActionTile(
            title: 'إعادة ضبط الإعدادات',
            subtitle: 'إرجاع كل الإعدادات للافتراضي',
            icon: Icons.restore,
            onTap: () => _showResetDialog(),
          ),

          const SizedBox(height: 24),

          // About
          _buildSectionHeader('عن التطبيق'),
          const SizedBox(height: 8),
          _buildInfoTile('الإصدار', AppConstants.appVersion),
          _buildInfoTile('الاسم', AppConstants.appDescription),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildProviderTile({
    required AIProvider provider,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryColor.withValues(alpha: 0.1) : AppTheme.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: AppTheme.primaryColor, width: 1.5) : null,
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : AppTheme.bgInput,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              provider.name[0],
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          provider.name,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
        ),
        subtitle: Text(
          provider.description,
          style: const TextStyle(color: AppTheme.textHint, fontSize: 12, fontFamily: 'Cairo'),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: AppTheme.primaryColor)
            : const Icon(Icons.circle_outlined, color: AppTheme.textHint),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSliderTile({
    required String title,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontFamily: 'Cairo')),
              Text(
                value.round().toString(),
                style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: AppTheme.primaryColor,
            inactiveColor: AppTheme.textHint.withValues(alpha: 0.2),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required VoidCallback onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontFamily: 'Cairo')),
        subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.textHint, fontSize: 12, fontFamily: 'Cairo')),
        value: value,
        activeThumbColor: AppTheme.primaryColor,
        onChanged: (_) => onChanged(),
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.errorColor),
        title: Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontFamily: 'Cairo')),
        subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.textHint, fontSize: 12, fontFamily: 'Cairo')),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textHint),
        onTap: onTap,
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(label, style: const TextStyle(color: AppTheme.textPrimary, fontFamily: 'Cairo')),
        trailing: Text(value, style: const TextStyle(color: AppTheme.textSecondary, fontFamily: 'Cairo')),
      ),
    );
  }

  void _showClearChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('مسح المحادثات', style: TextStyle(fontFamily: 'Cairo')),
        content: const Text(
          'هل أنت متأكد إنك عايز تمسح كل المحادثات؟ العملية دي مش هترجع.',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(chatProvider.notifier).clearChat();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor),
            child: const Text('مسح', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إعادة ضبط', style: TextStyle(fontFamily: 'Cairo')),
        content: const Text(
          'هل أنت متأكد إنك عايز ترجع الإعدادات للوضع الافتراضي؟',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(selectedProviderProvider.notifier).setProvider('gemini');
              ref.read(fontSizeProvider.notifier).setFontSize(16.0);
              ref.read(ttsEnabledProvider.notifier).toggle();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.warningColor),
            child: const Text('ضبط', style: TextStyle(fontFamily: 'Cairo', color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
