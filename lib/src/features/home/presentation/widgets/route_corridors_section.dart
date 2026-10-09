import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/utils/responsive_layout.dart';
import 'route_map_painter.dart';

class RouteCorridorsSection extends StatefulWidget {
  const RouteCorridorsSection({super.key});

  @override
  State<RouteCorridorsSection> createState() => _RouteCorridorsSectionState();
}

class _RouteCorridorsSectionState extends State<RouteCorridorsSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Breakpoints.isDesktop(context);

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Text(
              'NETWORK CORRIDORS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'From Dubai Industrial Zones to Every Emirate',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                'Wherever your cargo needs to go, our dispatch team coordinates the right vehicle for the corridor with zero detour delays.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                      height: 1.5,
                    ),
              ),
            ),
            const SizedBox(height: 40),

            // Card Container
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.surfaceVariant),
              ),
              padding: EdgeInsets.all(isDesktop ? 28 : 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: _buildMapVisualizer(context),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 4,
                          child: _buildCorridorDetails(),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildMapVisualizer(context),
                        const SizedBox(height: 24),
                        _buildCorridorDetails(),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapVisualizer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceVariant.withValues(alpha: 0.6),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Header Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Active Arteries: E11 & E311 Inter-Emirate Corridors',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                  ),
                ],
              ),
              if (!Breakpoints.isMobile(context))
                Text(
                  'Real-Time Telemetry Node',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                ),
            ],
          ),
          const SizedBox(height: 18),

          // Custom Painted Route Visualizer Canvas
          AspectRatio(
            aspectRatio: 760 / 300,
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return CustomPaint(
                  painter: RouteMapPainter(
                    animationValue: _animController.value,
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Bottom ETA Metric Chips
          Container(
            padding: const EdgeInsets.only(top: 14),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 16,
              runSpacing: 10,
              children: [
                _buildEtaChip(
                  context,
                  route: 'DXB → AUH: ',
                  eta: '~75 Mins',
                  color: AppColors.primary,
                ),
                _buildEtaChip(
                  context,
                  route: 'DXB → SHJ: ',
                  eta: '~25 Mins',
                  color: AppColors.secondary,
                ),
                _buildEtaChip(
                  context,
                  route: 'DXB → RAK: ',
                  eta: '~80 Mins',
                  color: AppColors.tertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEtaChip(
    BuildContext context, {
    required String route,
    required String eta,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.schedule, color: color, size: 16),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: AppColors.onSurface,
                ),
            children: [
              TextSpan(text: route),
              TextSpan(
                text: eta,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCorridorDetails() {
    return Column(
      children: [
        _buildCorridorCard(
          tag: 'WESTERN TRUNK',
          tagColor: AppColors.primary,
          badge: 'Priority Fast Track',
          badgeColor: AppColors.secondary,
          title: 'Dubai ⇄ Abu Dhabi',
          description:
              'Daily continuous shuttle runs between JAFZA and Mussafah industrial estates.',
        ),
        const SizedBox(height: 14),
        _buildCorridorCard(
          tag: 'NORTHERN CORRIDOR',
          tagColor: AppColors.secondary,
          badge: 'Multiple Daily Trips',
          badgeColor: AppColors.secondary,
          title: 'Dubai ⇄ Sharjah & Ajman',
          description:
              'Rapid express cargo routing via Emirates Road (E611) to avoid heavy peak traffic.',
        ),
        const SizedBox(height: 14),
        _buildCorridorCard(
          tag: 'EASTERN & NORTHERN',
          tagColor: AppColors.tertiary,
          badge: 'Scheduled',
          badgeColor: AppColors.onSurfaceVariant,
          title: 'RAK, Fujairah & UAQ',
          description:
              'Heavy machinery delivery and cross-emirate pallet transfers with full insurance coverage.',
        ),
      ],
    );
  }

  Widget _buildCorridorCard({
    required String tag,
    required Color tagColor,
    required String badge,
    required Color badgeColor,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tag,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: tagColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
              ),
              Text(
                badge,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: badgeColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  height: 1.45,
                ),
          ),
        ],
      ),
    );
  }
}
