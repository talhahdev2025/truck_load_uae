import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/utils/external_links.dart';
import '../../../../core/utils/responsive_layout.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onPostLoadPressed});

  final VoidCallback onPostLoadPressed;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Breakpoints.isDesktop(context);

    return Container(
      color: AppColors.surfaceContainerLowest,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ambient Glow effects
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryContainer.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: -100,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: isDesktop ? 80.0 : 40.0),
            child: ResponsiveContainer(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 7, child: _buildLeftPitch(context)),
                        const SizedBox(width: 48),
                        Expanded(flex: 5, child: _buildRightVisual(context)),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLeftPitch(context),
                        const SizedBox(height: 40),
                        _buildRightVisual(context),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftPitch(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eyebrow Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'DIRECT FREIGHT TRANSPORT',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              // const SizedBox(width: 8),
              // Container(
              //   width: 5,
              //   height: 5,
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: AppColors.outlineVariant,
              //   ),
              // ),
              // const SizedBox(width: 8),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Container(
              //       width: 7,
              //       height: 7,
              //       decoration: const BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: AppColors.secondary,
              //       ),
              //     ),
              //     // const SizedBox(width: 6),
              //     // Text(
              //     //   'DISPATCH ONLINE',
              //     //   style: Theme.of(context).textTheme.labelSmall?.copyWith(
              //     //         color: AppColors.secondary,
              //     //         fontWeight: FontWeight.w700,
              //     //         letterSpacing: 0.8,
              //     //       ),
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Main Headline
        RichText(
          text: TextSpan(
            style: isMobile
                ? Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                    height: 1.2,
                  )
                : Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                    height: 1.15,
                  ),
            children: const [
              TextSpan(text: 'Direct 3-Ton Freight Transport in '),
              TextSpan(
                text: 'Dubai & UAE',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            'Fast, reliable cargo transport across all Emirates. Post your load details and get an immediate confirmation call from our active 24/7 dispatch hub.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // CTAs
        Wrap(
          spacing: 16,
          runSpacing: 14,
          children: [
            ElevatedButton.icon(
              onPressed: onPostLoadPressed,
              icon: const Icon(Icons.local_shipping, size: 20),
              label: const Text('Post a Load'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 18,
                ),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => ExternalLinks.openWhatsApp(
                customMessage:
                    'Hello, I would like to post a load for transport.',
              ),
              // icon: const Icon(Icons.chat_bubble_outline, size: 20),
              icon: SvgPicture.asset(
                'assets/icons/whatsapp.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.onSecondary,
                  BlendMode.srcIn,
                ),
              ),
              label: const Text('WhatsApp Dispatch'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryContainer,
                foregroundColor: AppColors.onSecondary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 18,
                ),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 36),

        // Telemefy Badges Strip
        Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.surfaceVariant.withValues(alpha: 0.6),
              ),
            ),
          ),
          child: Wrap(
            spacing: 24,
            runSpacing: 14,
            children: [
              _buildTelemetryBadge(
                context,
                icon: Icons.timer_outlined,
                iconColor: AppColors.primary,
                title: 'Avg Response: ',
                highlight: '< 8 mins',
              ),
              _buildTelemetryBadge(
                context,
                icon: Icons.verified_user_outlined,
                iconColor: AppColors.secondary,
                title: 'Direct Carrier ',
                highlight: '/ Zero Brokers',
              ),
              _buildTelemetryBadge(
                context,
                icon: Icons.satellite_alt_outlined,
                iconColor: AppColors.tertiary,
                title: 'Live GPS ',
                highlight: 'Telematics',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTelemetryBadge(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String highlight,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
            children: [
              TextSpan(text: title),
              TextSpan(
                text: highlight,
                style: const TextStyle(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRightVisual(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Fleet Photo
            Image.asset(
              'assets/images/truck.jpg',
              height: 420,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 420,
                color: AppColors.surfaceContainer,
                child: const Center(
                  child: Icon(
                    Icons.local_shipping,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            // Gradient Shade
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.surfaceContainerLowest.withValues(alpha: 0.95),
                      AppColors.surfaceContainerLowest.withValues(alpha: 0.25),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Top-Right Dispatch Unit Tag
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.surfaceVariant),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '24/7 DISPATCH UNIT',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Specs Card
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.scale_rounded,
                              color: AppColors.primary,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '3.5T Payload Capacity',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                        Breakpoints.isMobile(context)
                            ? const SizedBox()
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColors.surfaceVariant,
                                  ),
                                ),
                                child: Text(
                                  'Box Trailer',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.surfaceVariant.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.hub_outlined,
                                color: AppColors.tertiary,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'UAE Nationwide Coverage',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: AppColors.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                          Breakpoints.isMobile(context)
                              ? const SizedBox()
                              : Text(
                                  'Dubai • AUH • SHJ • RAK',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
