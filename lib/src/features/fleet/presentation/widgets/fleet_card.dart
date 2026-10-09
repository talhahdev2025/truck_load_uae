import 'package:flutter/material.dart';
import 'package:truck_loads_uae/src/core/constants/app_colors.dart';
import 'package:truck_loads_uae/src/features/fleet/domain/entities/fleet_truck.dart';

class FleetCard extends StatefulWidget {
  const FleetCard({super.key, required this.truck, required this.onBook});

  final FleetTruck truck;
  final VoidCallback onBook;

  @override
  State<FleetCard> createState() => _FleetCardState();
}

class _FleetCardState extends State<FleetCard> {
  bool _isHovered = false;

  Color get _statusBgColor {
    switch (widget.truck.status) {
      case FleetStatus.available:
        return AppColors.secondary.withValues(alpha: 0.15);
      case FleetStatus.onDemand:
        return AppColors.tertiary.withValues(alpha: 0.15);
      case FleetStatus.certified:
        return AppColors.tertiaryFixedDim.withValues(alpha: 0.2);
    }
  }

  Color get _statusTextColor {
    switch (widget.truck.status) {
      case FleetStatus.available:
        return AppColors.secondary;
      case FleetStatus.onDemand:
        return AppColors.tertiary;
      case FleetStatus.certified:
        return AppColors.tertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final truck = widget.truck;
    final isPopular = truck.isPopular;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPopular
                ? AppColors.primaryContainer.withValues(alpha: 0.8)
                : (_isHovered ? AppColors.outline : AppColors.surfaceVariant),
            width: isPopular ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.35 : 0.15),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Floating Popular Pill
            if (isPopular)
              Positioned(
                top: -12,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryContainer.withValues(
                            alpha: 0.4,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'MOST POPULAR',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isPopular) const SizedBox(height: 8),
                      // Top Row: Status badge & Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _statusBgColor,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _statusTextColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              truck.status.label,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: _statusTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          Icon(
                            truck.icon,
                            color: AppColors.primary,
                            size: isPopular ? 30 : 26,
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Truck Name
                      Text(
                        truck.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),

                      // Payload Text
                      Text(
                        truck.payload,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 10),

                      // Description
                      Text(
                        truck.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),

                  // Bottom Button
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      padding: const EdgeInsets.only(top: 14),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.surfaceVariant.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.onBook,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isPopular
                              ? AppColors.primaryContainer
                              : AppColors.surfaceContainerHigh,
                          foregroundColor: isPopular
                              ? AppColors.onPrimary
                              : AppColors.onSurface,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Book ${truck.name.split(' ').first}',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: isPopular
                                    ? AppColors.onPrimary
                                    : AppColors.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
