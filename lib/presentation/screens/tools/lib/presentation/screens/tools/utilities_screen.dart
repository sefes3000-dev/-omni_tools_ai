import 'package:flutter/material.dart';
import '../../providers/tools_data.dart';
import '../../widgets/cards/tool_card.dart';

class UtilitiesScreen extends StatelessWidget {
  const UtilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = allTools.where((t) => t.category == 'Utilities').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Utilities')),
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
