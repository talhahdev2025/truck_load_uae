import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class TrustRowSection extends StatelessWidget {
  const TrustRowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.surfaceVariant),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ResponsiveContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;
            final isMedium = constraints.maxWidth > 550;

            if (isWide) {
              return Row(
                children: [
                  Expanded(
                    child: _buildItem(
                      context,
                      icon: Icons.support_agent_rounded,
                      iconColor: AppColors.primary,
                      title: '24/7 Dispatch',
                      subtitle: 'Active around the clock',
                    ),
                  ),
                  Expanded(
                    child: _buildItem(
                      context,
                      icon: Icons.explore_outlined,
                      iconColor: AppColors.secondary,
                      title: 'UAE-Wide Coverage',
                      subtitle: 'Dubai and all Emirates',
                    ),
                  ),
                  Expanded(
                    child: _buildItem(
                      context,
                      icon: Icons.swap_calls_rounded,
                      iconColor: AppColors.primary,
                      title: 'Direct Transport',
                      subtitle: 'Zero middlemen commission',
                    ),
                  ),
                  Expanded(
                    child: _buildItem(
                      context,
                      icon: Icons.bolt_rounded,
                      iconColor: AppColors.secondary,
                      title: 'Fast Response',
                      subtitle: '< 10 Min phone dispatch',
                    ),
                  ),
                ],
              );
            } else if (isMedium) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildItem(
                          context,
                          icon: Icons.support_agent_rounded,
                          iconColor: AppColors.primary,
                          title: '24/7 Dispatch',
                          subtitle: 'Active around the clock',
                        ),
                      ),
                      Expanded(
                        child: _buildItem(
                          context,
                          icon: Icons.explore_outlined,
                          iconColor: AppColors.secondary,
                          title: 'UAE-Wide Coverage',
                          subtitle: 'Dubai and all Emirates',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildItem(
                          context,
                          icon: Icons.swap_calls_rounded,
                          iconColor: AppColors.primary,
                          title: 'Direct Transport',
                          subtitle: 'Zero middlemen commission',
                        ),
                      ),
                      Expanded(
                        child: _buildItem(
                          context,
                          icon: Icons.bolt_rounded,
                          iconColor: AppColors.secondary,
                          title: 'Fast Response',
                          subtitle: '< 10 Min phone dispatch',
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildItem(
                    context,
                    icon: Icons.support_agent_rounded,
                    iconColor: AppColors.primary,
                    title: '24/7 Dispatch',
                    subtitle: 'Active around the clock',
                  ),
                  const SizedBox(height: 16),
                  _buildItem(
                    context,
                    icon: Icons.explore_outlined,
                    iconColor: AppColors.secondary,
                    title: 'UAE-Wide Coverage',
                    subtitle: 'Dubai and all Emirates',
                  ),
                  const SizedBox(height: 16),
                  _buildItem(
                    context,
                    icon: Icons.swap_calls_rounded,
                    iconColor: AppColors.primary,
                    title: 'Direct Transport',
                    subtitle: 'Zero middlemen commission',
                  ),
                  const SizedBox(height: 16),
                  _buildItem(
                    context,
                    icon: Icons.bolt_rounded,
                    iconColor: AppColors.secondary,
                    title: 'Fast Response',
                    subtitle: '< 10 Min phone dispatch',
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
