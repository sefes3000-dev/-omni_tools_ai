import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';

class PremiumScreen extends ConsumerWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFFEC4899), Color(0xFF14B8A6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.workspace_premium, size: 80, color: Colors.white),
                    const SizedBox(height: 16),
                    Text('Go Premium', style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Unlock the full power of OmniTools AI', style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildFeatureItem(Icons.block, 'Remove All Ads', 'Enjoy an ad-free experience'),
                  _buildFeatureItem(Icons.psychology, 'AI Tools', 'Access all AI-powered tools'),
                  _buildFeatureItem(Icons.auto_awesome, 'Future Tools', 'Get all upcoming advanced tools'),
                  _buildFeatureItem(Icons.support_agent, 'Priority Support', 'Get help when you need it'),
                  const SizedBox(height: 32),
                  _buildPricingCard(context, 'Monthly', '\$4.99/month', 'Billed monthly', false, ref),
                  const SizedBox(height: 16),
                  _buildPricingCard(context, 'Yearly', '\$29.99/year', 'Save 50%', true, ref),
                  const SizedBox(height: 16),
                  _buildPricingCard(context, 'Lifetime', '\$79.99', 'One-time payment', false, ref),
                  const SizedBox(height: 32),
                  Text('Restore purchases', style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.primaryLight)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryLight),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: AppColors.successLight),
        ],
      ),
    );
  }

  Widget _buildPricingCard(BuildContext context, String title, String price, String subtitle, bool isRecommended, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isRecommended ? AppColors.primaryLight : Colors.grey[300]!,
          width: isRecommended ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
        color: isRecommended ? AppColors.primaryLight.withOpacity(0.05) : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        title: Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            if (isRecommended) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('BEST', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ],
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primaryLight)),
        onTap: () {
          ref.read(premiumProvider.notifier).setPremium(true);
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Premium activated! Thank you for your support.')),
          );
        },
      ),
    );
  }
}
