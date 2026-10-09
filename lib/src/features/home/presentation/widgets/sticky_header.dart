import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/utils/external_links.dart';

class StickyHeader extends StatelessWidget implements PreferredSizeWidget {
  const StickyHeader({
    super.key,
    required this.onNavigate,
    required this.onOpenMobileMenu,
  });

  final void Function(String sectionKey) onNavigate;
  final VoidCallback onOpenMobileMenu;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Breakpoints.isDesktop(context);
    final isTablet = Breakpoints.isTablet(context);

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.94),
        border: const Border(
          bottom: BorderSide(color: AppColors.surfaceVariant),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48.0 : 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo & Status Badge
                Row(
                  children: [
                    Image.network(
                      AppConstants.logoUrl,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.local_shipping,
                        color: AppColors.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      AppConstants.appName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: AppColors.onSurface,
                          ),
                    ),
                  ],
                ),

                // Desktop Nav Links
                if (isDesktop)
                  Row(
                    children: [
                      _buildNavLink(context, 'Home', 'home', isActive: true),
                      const SizedBox(width: 24),
                      _buildNavLink(context, 'About Us', 'about-us'),
                      const SizedBox(width: 24),
                      _buildNavLink(context, 'Post Load', 'post-load'),
                      const SizedBox(width: 24),
                      _buildNavLink(context, 'Our Truck', 'our-fleet'),
                      const SizedBox(width: 24),
                      _buildNavLink(context, 'Contact Us', 'contact-us'),
                    ],
                  ),

                // Right Actions
                Row(
                  children: [
                    // Phone Call Button
                    ElevatedButton.icon(
                      onPressed: ExternalLinks.callDispatch,
                      icon: const Icon(Icons.phone_in_talk, size: 16),
                      label: Text(
                        Breakpoints.isMobile(context) ? 'Dispatch' : 'Call / WhatsApp Us',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: AppColors.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Mobile Menu Toggle
                    if (!isDesktop) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: onOpenMobileMenu,
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.onSurface,
                          size: 26,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(
    BuildContext context,
    String label,
    String key, {
    bool isActive = false,
  }) {
    return InkWell(
      onTap: () => onNavigate(key),
      hoverColor: Colors.transparent,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isActive ? AppColors.primary : AppColors.onSurfaceVariant,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            ),
      ),
    );
  }
}
