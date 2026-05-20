import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../providers/memory_provider.dart';

class MemoryScreen extends ConsumerStatefulWidget {
  const MemoryScreen({super.key});

  @override
  ConsumerState<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends ConsumerState<MemoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _addController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(memoryProvider.notifier).loadMemories();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _addController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memoryState = ref.watch(memoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الذاكرة'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: AppTheme.textPrimary, fontFamily: 'Cairo'),
              decoration: InputDecoration(
                hintText: 'ابحث في الذاكرة...',
                hintStyle: const TextStyle(fontFamily: 'Cairo'),
                prefixIcon: const Icon(Icons.search, color: AppTheme.textHint),
                suffixIcon: IconButton(
                  onPressed: () => _searchMemories(),
                  icon: const Icon(Icons.arrow_forward, color: AppTheme.primaryColor),
                ),
              ),
              onSubmitted: (_) => _searchMemories(),
            ),
          ),

          // Memory List
          Expanded(
            child: memoryState.isLoading
                ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor))
                : memoryState.memories.isEmpty
                    ? _buildEmptyState()
                    : _buildMemoryList(memoryState),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMemoryDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.psychology_outlined, size: 80, color: AppTheme.textHint),
          const SizedBox(height: 16),
          const Text(
            'مفيش ذكريات لسه',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'أوج هيحفظ ذكرياتك كل ما تتكلم معاه',
            style: TextStyle(
              color: AppTheme.textHint,
              fontSize: 14,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryList(MemoryState state) {
    return RefreshIndicator(
      onRefresh: () => ref.read(memoryProvider.notifier).loadMemories(),
      color: AppTheme.primaryColor,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: state.memories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final memory = state.memories[index];
          return Dismissible(
            key: Key(memory.id),
            direction: DismissDirection.startToEnd,
            background: Container(
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: AppTheme.errorColor),
            ),
            onDismissed: (_) => ref.read(memoryProvider.notifier).deleteMemory(memory.id),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      memory.content,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 14,
                        fontFamily: 'Cairo',
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _searchMemories() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    ref.read(memoryProvider.notifier).searchMemories(query);
  }

  void _showAddMemoryDialog() {
    _addController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة ذكرى', style: TextStyle(fontFamily: 'Cairo')),
        content: TextField(
          controller: _addController,
          style: const TextStyle(color: AppTheme.textPrimary, fontFamily: 'Cairo'),
          decoration: const InputDecoration(
            hintText: 'اكتب الذكرى هنا...',
            hintStyle: TextStyle(fontFamily: 'Cairo'),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              if (_addController.text.trim().isNotEmpty) {
                ref.read(memoryProvider.notifier).addMemory(_addController.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text('إضافة', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }
}
