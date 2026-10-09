import 'package:flutter/material.dart';
import 'package:truck_loads_uae/src/core/constants/app_colors.dart';
import 'package:truck_loads_uae/src/core/constants/breakpoints.dart';
import 'package:truck_loads_uae/src/core/utils/responsive_layout.dart';
import 'package:truck_loads_uae/src/features/fleet/presentation/widgets/fleet_overview_section.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/app_drawer.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/app_footer.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/capabilities_chip_row.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/contact_dispatch_section.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/hero_section.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/how_it_works_section.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/industrial_corridors_section.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/mobile_bottom_action_bar.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/route_corridors_section.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/service_info_grid_section.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/sticky_header.dart';
import 'package:truck_loads_uae/src/features/home/presentation/widgets/trust_row_section.dart';
import 'package:truck_loads_uae/src/features/load_booking/presentation/widgets/load_booking_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
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
      key: _scaffoldKey, // <-- Pass key directly to Scaffold
      drawer: AppDrawer(
        onNavigate: _handleNavigation, // <-- Pass the navigation handler
      ),
      backgroundColor: AppColors.background,
      appBar: StickyHeader(
        onNavigate: _handleNavigation,
        onOpenMobileMenu: _openDrawer,
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
            Container(
              key: _homeKey,
              child: HeroSection(
                onPostLoadPressed: () => _scrollToKey(_postLoadKey),
              ),
            ),
            const TrustRowSection(),
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
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
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
            Container(
              key: _aboutKey,
              child: const IndustrialCorridorsSection(),
            ),
            Container(
              key: _fleetKey,
              child: FleetOverviewSection(
                onSelectTruck: (truckType) => _scrollToKey(_postLoadKey),
              ),
            ),
            Container(
              key: _capabilitiesKey,
              child: const CapabilitiesChipRow(),
            ),
            // const RouteCorridorsSection(),
            const HowItWorksSection(),
            Container(key: _contactKey, child: const ContactDispatchSection()),
            const ServiceInfoGridSection(),
            AppFooter(onNavigate: _handleNavigation),
          ],
        ),
      ),
    );
  }
}
