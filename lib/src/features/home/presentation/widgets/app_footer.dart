import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/external_links.dart';
import '../../../../core/utils/responsive_layout.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key, required this.onNavigate});

  final void Function(String sectionKey) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(top: BorderSide(color: AppColors.surfaceVariant)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: ResponsiveContainer(
        child: Column(
          children: [
            // 4 Column Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 900;
                final isMedium = constraints.maxWidth > 550;

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _buildCol1(context)),
                      const SizedBox(width: 32),
                      Expanded(flex: 2, child: _buildCol2(context)),
                      const SizedBox(width: 32),
                      Expanded(flex: 3, child: _buildCol3(context)),
                      const SizedBox(width: 32),
                      Expanded(flex: 2, child: _buildCol4(context)),
                    ],
                  );
                } else if (isMedium) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildCol1(context)),
                          const SizedBox(width: 24),
                          Expanded(child: _buildCol2(context)),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildCol3(context)),
                          const SizedBox(width: 24),
                          Expanded(child: _buildCol4(context)),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCol1(context),
                      const SizedBox(height: 32),
                      _buildCol2(context),
                      const SizedBox(height: 32),
                      _buildCol3(context),
                      const SizedBox(height: 32),
                      _buildCol4(context),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 48),

            // Bottom Bar
            Container(
              padding: const EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.surfaceVariant.withValues(alpha: 0.6),
                  ),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  return isWide
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Copyright © 2026 TruckLoad UAE. All rights reserved.',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.onSurfaceVariant),
                            ),
                            _buildLegalLinks(context),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Copyright © 2026 TruckLoad UAE. All rights reserved.',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.onSurfaceVariant),
                            ),
                            const SizedBox(height: 12),
                            _buildLegalLinks(context),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCol1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Direct Cargo Transport across Dubai & UAE. Industrial-grade freight management with real-time tracking and zero brokerage ambiguity.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.onSurfaceVariant,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildBadge(context, 'RTA Freight Lic. #DXB-9982'),
            _buildBadge(context, 'ISO 9001 Logistics'),
          ],
        ),
      ],
    );
  }

  Widget _buildCol2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK NAVIGATION',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        _buildFooterLink('Home', () => onNavigate('home')),
        _buildFooterLink('About Us', () => onNavigate('about-us')),
        _buildFooterLink('Post Load', () => onNavigate('post-load')),
        _buildFooterLink('Our Fleet', () => onNavigate('our-fleet')),
        _buildFooterLink('Capabilities', () => onNavigate('capabilities')),
        _buildFooterLink('Contact Us', () => onNavigate('contact-us')),
        _buildFooterLink('Operator Login', () => onNavigate('contact-us')),
      ],
    );
  }

  Widget _buildCol3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '24/7 OPERATIONS HUB',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Central Dispatch Hotline:',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: ExternalLinks.callDispatch,
          child: Text(
            AppConstants.dispatchPhoneHotline,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Operational Control Center:',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 4),
        Text(
          AppConstants.operationalCenterAddress,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.onSurface,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildCol4(BuildContext context) {
    const zones = ['JAFZA', 'Al Quoz', 'DIP', 'Mussafah', 'DIC'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COVERAGE ZONES',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Rapid response fleet stations positioned across key industrial belts:',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.onSurfaceVariant,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: zones.map((z) => _buildZoneBadge(context, z)).toList(),
        ),
      ],
    );
  }

  Widget _buildFooterLink(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.onSurfaceVariant,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildZoneBadge(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLegalLinks(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLegalLink('Terms of Carriage'),
        const SizedBox(width: 16),
        _buildLegalLink('Privacy Policy'),
      ],
    );
  }

  Widget _buildLegalLink(String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: const TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12),
      ),
    );
  }
}
