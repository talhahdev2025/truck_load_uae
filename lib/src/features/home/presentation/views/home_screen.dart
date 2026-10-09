import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/utils/external_links.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../fleet/presentation/widgets/fleet_overview_section.dart';
import '../../../load_booking/presentation/widgets/load_booking_form.dart';
import '../widgets/app_footer.dart';
import '../widgets/capabilities_chip_row.dart';
import '../widgets/contact_dispatch_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/how_it_works_section.dart';
import '../widgets/industrial_corridors_section.dart';
import '../widgets/mobile_bottom_action_bar.dart';
import '../widgets/route_corridors_section.dart';
import '../widgets/service_info_grid_section.dart';
import '../widgets/sticky_header.dart';
import '../widgets/trust_row_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _postLoadKey = GlobalKey();
  final GlobalKey _fleetKey = GlobalKey();
  final GlobalKey _capabilitiesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToKey(GlobalKey key) {
    final currentContext = key.currentContext;
    if (currentContext != null) {
      Scrollable.ensureVisible(
        currentContext,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  void _handleNavigation(String sectionKey) {
    switch (sectionKey) {
      case 'home':
        _scrollToKey(_homeKey);
        break;
      case 'about-us':
        _scrollToKey(_aboutKey);
        break;
      case 'post-load':
        _scrollToKey(_postLoadKey);
        break;
      case 'our-fleet':
        _scrollToKey(_fleetKey);
        break;
      case 'capabilities':
        _scrollToKey(_capabilitiesKey);
        break;
      case 'contact-us':
        _scrollToKey(_contactKey);
        break;
      default:
        _scrollToKey(_homeKey);
    }
  }

  void _openMobileDrawer() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Navigation Menu',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(color: AppColors.surfaceVariant),
                ListTile(
                  leading: const Icon(Icons.home_outlined, color: AppColors.primary),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToKey(_homeKey);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.domain_rounded, color: AppColors.primary),
                  title: const Text('About Us'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToKey(_aboutKey);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping_outlined, color: AppColors.primary),
                  title: const Text('Post Load'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToKey(_postLoadKey);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.rv_hookup, color: AppColors.primary),
                  title: const Text('Our Truck'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToKey(_fleetKey);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_phone_outlined, color: AppColors.primary),
                  title: const Text('Contact Us'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToKey(_contactKey);
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ExternalLinks.callDispatch();
                  },
                  icon: const Icon(Icons.phone_in_talk, size: 18),
                  label: const Text('Call Dispatch Desk'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: StickyHeader(
        onNavigate: _handleNavigation,
        onOpenMobileMenu: _openMobileDrawer,
      ),
      bottomNavigationBar: isMobile
          ? MobileBottomActionBar(
              onPostLoadPressed: () => _scrollToKey(_postLoadKey),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // 1. Hero Section
            Container(
              key: _homeKey,
              child: HeroSection(
                onPostLoadPressed: () => _scrollToKey(_postLoadKey),
              ),
            ),

            // 2. Compact Trust Row
            const TrustRowSection(),

            // 3. Instant Booking Engine (Load Request Form)
            Container(
              key: _postLoadKey,
              color: AppColors.background,
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: ResponsiveContainer(
                child: Column(
                  children: [
                    Text(
                      'INSTANT BOOKING ENGINE',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Need a Truck? Post Your Load.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Text(
                        "Tell us what you're moving, where it's going, and when you need it. Our dedicated operator will call you in real time to lock down your booking.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.onSurfaceVariant,
                              height: 1.5,
                            ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const LoadBookingForm(),
                  ],
                ),
              ),
            ),

            // 4. Industrial Operations & Strategic Corridors
            Container(
              key: _aboutKey,
              child: const IndustrialCorridorsSection(),
            ),

            // 5. Fleet Overview Section (5 cards)
            Container(
              key: _fleetKey,
              child: FleetOverviewSection(
                onSelectTruck: (truckType) => _scrollToKey(_postLoadKey),
              ),
            ),

            // 6. Capabilities Chip Row
            Container(
              key: _capabilitiesKey,
              child: const CapabilitiesChipRow(),
            ),

            // 7. Route Corridors & Visualizer Section
            const RouteCorridorsSection(),

            // 8. How It Works (3 Steps)
            const HowItWorksSection(),

            // 9. Contact & Direct Dispatch Section
            Container(
              key: _contactKey,
              child: const ContactDispatchSection(),
            ),

            // 10. Service Info Grid (KPIs)
            const ServiceInfoGridSection(),

            // 11. Footer
            AppFooter(
              onNavigate: _handleNavigation,
            ),
          ],
        ),
      ),
    );
  }
}
