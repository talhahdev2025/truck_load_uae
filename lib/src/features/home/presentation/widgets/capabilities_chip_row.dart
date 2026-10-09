import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class CapabilitiesChipRow extends StatelessWidget {
  const CapabilitiesChipRow({super.key});

  @override
  Widget build(BuildContext context) {
    const chips = [
      (Icons.scale_rounded, AppColors.primary, '3.5 Ton Payload Capacity'),
      (Icons.line_weight_rounded, AppColors.primary, 'Box Trailer with Hydraulic Tailgate'),
      (Icons.gps_fixed_rounded, AppColors.secondary, 'GPS Monitored'),
      (Icons.key_rounded, AppColors.primary, 'JAFZA Gate Pass Ready'),
      (Icons.public_rounded, AppColors.tertiary, 'UAE-Wide Coverage'),
      (Icons.alarm_on_rounded, AppColors.secondary, '24/7 Dispatch'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh.withValues(alpha: 0.6),
        border: const Border.symmetric(
          horizontal: BorderSide(color: AppColors.surfaceVariant),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ResponsiveContainer(
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: chips.map((c) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.surfaceVariant),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(c.$1, color: c.$2, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      c.$3,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
