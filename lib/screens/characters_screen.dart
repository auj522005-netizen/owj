import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../providers/app_providers.dart';

class CharactersScreen extends ConsumerWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCharacter = ref.watch(selectedCharacterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الشخصيات'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: AppConstants.characterNames.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final key = AppConstants.characterNames.keys.elementAt(index);
          final name = AppConstants.characterNames[key]!;
          final icon = AppConstants.characterIcons[key]!;
          final prompt = AppConstants.characterPrompts[key]!;
          final color = Color(AppConstants.characterColors[key] ?? 0xFF6C63FF);
          final isSelected = key == selectedCharacter;

          return _CharacterCard(
            name: name,
            icon: icon,
            description: prompt,
            color: color,
            isSelected: isSelected,
            onTap: () {
              ref.read(selectedCharacterProvider.notifier).setCharacter(key);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  final String name;
  final String icon;
  final String description;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _CharacterCard({
    required this.name,
    required this.icon,
    required this.description,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.05)],
                )
              : null,
          color: isSelected ? null : AppTheme.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: color, width: 2)
              : Border.all(color: AppTheme.textHint.withValues(alpha: 0.1)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.6)],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: isSelected
                      ? [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 12)]
                      : null,
                ),
                child: Center(child: Text(icon, style: const TextStyle(fontSize: 28))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: isSelected ? color : AppTheme.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 8),
                          Icon(Icons.check_circle, color: color, size: 18),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: AppTheme.textHint,
                        fontSize: 12,
                        fontFamily: 'Cairo',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: isSelected ? color : AppTheme.textHint,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
