import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    const steps = [
      (
        '01',
        'Post Your Load',
        'Enter pickup location, destination, cargo specs, and preferred date on our website or via quick WhatsApp chat.',
        Icons.edit_document,
        'Instant digital logging',
        AppColors.primary,
      ),
      (
        '02',
        'Get a Fast Response',
        'Our central dispatch operator verifies vehicle availability and calls you within 10 minutes with confirmed rates.',
        Icons.phone_in_talk,
        'Transparent fixed pricing',
        AppColors.secondary,
      ),
      (
        '03',
        'We Move Your Cargo',
        'The assigned 1T, 3T, or 7T truck arrives on schedule. Your cargo is transported securely to its recipient with proof of delivery.',
        Icons.task_alt,
        'Verified electronic POD',
        AppColors.tertiary,
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.surfaceVariant),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: ResponsiveContainer(
        child: Column(
          children: [
            // Header
            Text(
              'SIMPLE 3-STEP PROCESS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'How Direct Transport Works',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Text(
                'Zero paperwork confusion. Simple, direct communication from inquiry to offloading.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
              ),
            ),
            const SizedBox(height: 48),

            // 3 Columns Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 800;
                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: steps.map((s) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _buildStepCard(context, s),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Column(
                    children: steps.map((s) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: _buildStepCard(context, s),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(
    BuildContext context,
    (String, String, String, IconData, String, Color) s,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.$1,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: s.$6.withValues(alpha: 0.35),
                  fontSize: 48,
                  height: 1.0,
                ),
          ),
          const SizedBox(height: 14),
          Text(
            s.$2,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            s.$3,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(top: 14),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(s.$4, color: s.$6, size: 18),
                const SizedBox(width: 8),
                Text(
                  s.$5,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: s.$6,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
