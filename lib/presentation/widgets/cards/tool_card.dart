import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/tool_model.dart';
import '../../../core/theme/app_colors.dart';

class ToolCard extends StatelessWidget {
  final ToolModel tool;

  const ToolCard({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.push(tool.route),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getCategoryColor(tool.category).withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconData(tool.icon),
                color: _getCategoryColor(tool.category),
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                tool.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),
            if (tool.isPremium)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.warningLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'PRO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (tool.isNew)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'File Tools': return AppColors.fileTools;
      case 'Image Tools': return AppColors.imageTools;
      case 'Video Tools': return AppColors.videoTools;
      case 'PDF Tools': return AppColors.pdfTools;
      case 'Text Tools': return AppColors.textTools;
      case 'AI Tools': return AppColors.aiTools;
      case 'Network Tools': return AppColors.networkTools;
      case 'Phone Tools': return AppColors.phoneTools;
      case 'Security Tools': return AppColors.securityTools;
      case 'Developer Tools': return AppColors.developerTools;
      case 'Calculators': return AppColors.calculators;
      case 'Utilities': return AppColors.utilities;
      default: return AppColors.primaryLight;
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'folder': return Icons.folder;
      case 'compress': return Icons.compress;
      case 'aspect_ratio': return Icons.aspect_ratio;
      case 'document_scanner': return Icons.document_scanner;
      case 'find_duplicate': return Icons.find_in_page;
      case 'picture_as_pdf': return Icons.picture_as_pdf;
      case 'merge_type': return Icons.merge_type;
      case 'splitscreen': return Icons.splitscreen;
      case 'format_list_numbered': return Icons.format_list_numbered;
      case 'text_fields': return Icons.text_fields;
      case 'code': return Icons.code;
      case 'fingerprint': return Icons.fingerprint;
      case 'encode': return Icons.enhanced_encryption;
      case 'decode': return Icons.no_encryption;
      case 'auto_awesome': return Icons.auto_awesome;
      case 'summarize': return Icons.summarize;
      case 'translate': return Icons.translate;
      case 'speed': return Icons.speed;
      case 'wifi': return Icons.wifi;
      case 'download': return Icons.download;
      case 'flashlight_on': return Icons.flashlight_on;
      case 'explore': return Icons.explore;
      case 'devices': return Icons.devices;
      case 'battery_full': return Icons.battery_full;
      case 'password': return Icons.password;
      case 'shield': return Icons.shield;
      case 'tag': return Icons.tag;
      case 'qr_code_scanner': return Icons.qr_code_scanner;
      case 'qr_code': return Icons.qr_code;
      case 'barcode_reader': return Icons.barcode_reader;
      case 'colorize': return Icons.colorize;
      case 'gradient': return Icons.gradient;
      case 'swap_horiz': return Icons.swap_horiz;
      case 'currency_exchange': return Icons.currency_exchange;
      case 'cake': return Icons.cake;
      case 'monitor_weight': return Icons.monitor_weight;
      case 'percent': return Icons.percent;
      case 'casino': return Icons.casino;
      case 'timer': return Icons.timer;
      case 'hourglass_empty': return Icons.hourglass_empty;
      case 'note': return Icons.note;
      case 'storage': return Icons.storage;
      case 'find_in_page': return Icons.find_in_page;
      case 'vpn_key': return Icons.vpn_key;
      default: return Icons.build;
    }
  }
}
