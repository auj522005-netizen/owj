import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/memory_service.dart';

/// Memory state
class MemoryState {
  final List<MemoryData> memories;
  final bool isLoading;
  final String? error;

  const MemoryState({
    this.memories = const [],
    this.isLoading = false,
    this.error,
  });

  MemoryState copyWith({
    List<MemoryData>? memories,
    bool? isLoading,
    String? error,
  }) {
    return MemoryState(
      memories: memories ?? this.memories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Memory notifier - Riverpod 3 Notifier API
class MemoryNotifier extends Notifier<MemoryState> {
  @override
  MemoryState build() => const MemoryState();

  String get userId => 'owj_user';

  Future<void> loadMemories() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final memories = await MemoryService.getMemories(userId);
      state = state.copyWith(memories: memories, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addMemory(String content) async {
    final success = await MemoryService.addMemory(userId, content);
    if (success) {
      await loadMemories();
    }
  }

  Future<void> deleteMemory(String memoryId) async {
    final success = await MemoryService.deleteMemory(memoryId);
    if (success) {
      await loadMemories();
    }
  }

  Future<List<MemoryData>> searchMemories(String query) async {
    return await MemoryService.searchMemories(userId, query);
  }
}

/// Memory provider
final memoryProvider = NotifierProvider<MemoryNotifier, MemoryState>(() {
  return MemoryNotifier();
});
