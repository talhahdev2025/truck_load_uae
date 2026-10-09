import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/constants/app_constants.dart';
import 'src/core/theme/app_theme.dart';
import 'src/features/home/presentation/views/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: TruckLoadsUaeApp()));
}

class TruckLoadsUaeApp extends StatelessWidget {
  const TruckLoadsUaeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${AppConstants.appName} - Direct Freight Transport Dubai & UAE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
