import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';
import '../../providers/tools_data.dart';
import '../../widgets/cards/tool_card.dart';

class AiToolsScreen extends ConsumerWidget {
  const AiToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(premiumProvider);
    final tools = allTools.where((t) => t.category == 'AI Tools').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('AI Tools')),
      body: !isPremium
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock, size: 64, color: AppColors.warningLight),
                  const SizedBox(height: 16),
                  Text('Premium Required', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  const Text('Upgrade to access AI-powered tools'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed('/premium'),
                    child: const Text('Go Premium'),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: tools.length,
              itemBuilder: (context, index) => ToolCard(tool: tools[index]),
            ),
    );
  }
}
