import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_providers.dart';
import '../../providers/tools_data.dart';
import '../../widgets/cards/tool_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final favoriteTools = allTools.where((t) => favorites.contains(t.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoriteTools.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('No favorites yet', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Tap the heart icon on any tool to add it here',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                ],
              ),
            )
          : ReorderableGridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: favoriteTools.length,
              onReorder: (oldIndex, newIndex) {},
              itemBuilder: (context, index) => ToolCard(
                key: ValueKey(favoriteTools[index].id),
                tool: favoriteTools[index],
              ),
            ),
    );
  }
}
