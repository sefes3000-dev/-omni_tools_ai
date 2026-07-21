import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/app_providers.dart';
import '../../providers/tools_data.dart';
import '../../widgets/cards/tool_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchHistory = ref.watch(searchHistoryProvider);
    final filteredTools = _query.isEmpty
        ? <ToolModel>[]
        : allTools.where((t) =>
            t.name.toLowerCase().contains(_query.toLowerCase()) ||
            t.description.toLowerCase().contains(_query.toLowerCase()) ||
            t.category.toLowerCase().contains(_query.toLowerCase())
          ).toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search tools...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
          ),
          style: Theme.of(context).textTheme.bodyLarge,
          onChanged: (value) => setState(() => _query = value),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              ref.read(searchHistoryProvider.notifier).addSearch(value);
            }
          },
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() => _query = '');
              },
            ),
        ],
      ),
      body: _query.isEmpty
          ? ListView(
              children: [
                if (searchHistory.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recent Searches', style: Theme.of(context).textTheme.titleMedium),
                        TextButton(
                          onPressed: () => ref.read(searchHistoryProvider.notifier).clearHistory(),
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  ),
                  ...searchHistory.map((query) => ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(query),
                    trailing: const Icon(Icons.north_west),
                    onTap: () {
                      _searchController.text = query;
                      setState(() => _query = query);
                    },
                  )),
                ],
              ],
            )
          : filteredTools.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text('No tools found', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredTools.length,
                  itemBuilder: (context, index) => ToolCard(tool: filteredTools[index]),
                ),
    );
  }
}
