import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../load_booking/presentation/controllers/load_booking_controller.dart';
import '../../data/datasources/mock_fleet_data.dart';
import 'fleet_card.dart';

class FleetOverviewSection extends ConsumerWidget {
  const FleetOverviewSection({
    super.key,
    required this.onSelectTruck,
  });

  final void Function(String truckType) onSelectTruck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 768;
                return isWide
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildHeaderTexts(context),
                          _buildSubtitle(context, maxWidth: 440),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderTexts(context),
                          const SizedBox(height: 12),
                          _buildSubtitle(context),
                        ],
                      );
              },
            ),
            const SizedBox(height: 48),

            // Responsive 5-card grid
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                int crossAxisCount = 1;
                double childAspectRatio = 0.85;

                if (width >= 1150) {
                  crossAxisCount = 5;
                  childAspectRatio = 0.68;
                } else if (width >= 900) {
                  crossAxisCount = 3;
                  childAspectRatio = 0.8;
                } else if (width >= 580) {
                  crossAxisCount = 2;
                  childAspectRatio = 0.82;
                } else {
                  crossAxisCount = 1;
                  childAspectRatio = 1.1;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: MockFleetData.trucks.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 20,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    final truck = MockFleetData.trucks[index];
                    return FleetCard(
                      truck: truck,
                      onBook: () {
                        ref.read(selectedTruckTypeProvider.notifier).state =
                            truck.bookingTruckTypeValue;
                        onSelectTruck(truck.bookingTruckTypeValue);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HARDWARE SPECIFICATIONS',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Built for Real Cargo',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context, {double? maxWidth}) {
    final text = Text(
      'Maintained to strict UAE RTA technical standards. Every truck features GPS telemetry and experienced commercial pilots.',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.onSurfaceVariant,
            height: 1.5,
          ),
    );

    if (maxWidth != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: text,
      );
    }
    return text;
  }
}
