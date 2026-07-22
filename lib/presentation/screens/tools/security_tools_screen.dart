import 'package:flutter/material.dart';
import '../../providers/tools_data.dart';
import '../../widgets/cards/tool_card.dart';

class SecurityToolsScreen extends StatelessWidget {
  const SecurityToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = allTools.where((t) => t.category == 'Security Tools').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Security Tools')),
      body: GridView.builder(
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
