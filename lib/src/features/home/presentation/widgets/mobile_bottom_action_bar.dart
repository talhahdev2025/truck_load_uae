import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/external_links.dart';

class MobileBottomActionBar extends StatelessWidget {
  const MobileBottomActionBar({super.key, required this.onPostLoadPressed});

  final VoidCallback onPostLoadPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: const Border(top: BorderSide(color: AppColors.surfaceVariant)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // WhatsApp
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => ExternalLinks.openWhatsApp(),
                icon: SvgPicture.asset(
                  'assets/icons/whatsapp.svg',
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.onSecondary,
                    BlendMode.srcIn,
                  ),
                ),
                label: const Text('WhatsApp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryContainer,
                  foregroundColor: AppColors.onSecondary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Call Dispatch
            Expanded(
              child: OutlinedButton.icon(
                onPressed: ExternalLinks.callDispatch,
                icon: const Icon(Icons.call_rounded, size: 16),
                label: const Text('Dispatch'),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainerHigh,
                  foregroundColor: AppColors.onSurface,
                  side: const BorderSide(color: AppColors.surfaceVariant),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Post Load
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onPostLoadPressed,
                icon: const Icon(Icons.local_shipping_rounded, size: 16),
                label: const Text('Post Load'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
