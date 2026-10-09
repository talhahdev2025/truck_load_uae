import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class ServiceInfoGridSection extends StatelessWidget {
  const ServiceInfoGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        'SERVICE AREA',
        'Dubai & All Emirates',
        'Nationwide UAE Jurisdiction',
        AppColors.primary,
      ),
      (
        'DISPATCH ACTIVE',
        '24 Hours / 365 Days',
        'Continuous Monitoring Shift',
        AppColors.secondary,
      ),
      (
        'BUSINESS MODEL',
        'Direct Cargo Transport',
        'No Middleman Brokerage',
        AppColors.onSurfaceVariant,
      ),
      (
        'RESPONSE TARGET',
        '< 10 Minutes',
        'Direct Voice Confirmation',
        AppColors.primary,
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(color: AppColors.surfaceVariant),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: ResponsiveContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 900;
            final isTablet = constraints.maxWidth > 550;

            if (isDesktop) {
              return Row(
                children: items.map((item) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _buildInfoCard(context, item),
                    ),
                  );
                }).toList(),
              );
            } else if (isTablet) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildInfoCard(context, items[0])),
                      const SizedBox(width: 14),
                      Expanded(child: _buildInfoCard(context, items[1])),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _buildInfoCard(context, items[2])),
                      const SizedBox(width: 14),
                      Expanded(child: _buildInfoCard(context, items[3])),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildInfoCard(context, item),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    (String, String, String, Color) item,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.$1,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            item.$2,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            item.$3,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: item.$4,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}
