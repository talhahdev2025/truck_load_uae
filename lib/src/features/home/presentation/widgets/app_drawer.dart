import 'package:flutter/material.dart';
import 'package:truck_loads_uae/src/core/constants/app_colors.dart';
import 'package:truck_loads_uae/src/core/utils/external_links.dart';

class AppDrawer extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const AppDrawer({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
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
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: AppColors.surfaceVariant),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.home_outlined,
                        color: AppColors.primary,
                      ),
                      title: const Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                        onNavigate('home');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.domain_rounded,
                        color: AppColors.primary,
                      ),
                      title: const Text('About Us'),
                      onTap: () {
                        Navigator.pop(context);
                        onNavigate('about-us');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.local_shipping_outlined,
                        color: AppColors.primary,
                      ),
                      title: const Text('Post Load'),
                      onTap: () {
                        Navigator.pop(context);
                        onNavigate('post-load');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.rv_hookup,
                        color: AppColors.primary,
                      ),
                      title: const Text('Our Truck'),
                      onTap: () {
                        Navigator.pop(context);
                        onNavigate('our-fleet');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.contact_phone_outlined,
                        color: AppColors.primary,
                      ),
                      title: const Text('Contact Us'),
                      onTap: () {
                        Navigator.pop(context);
                        onNavigate('contact-us');
                      },
                    ),
                  ],
                ),
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
      ),
    );
  }
}
