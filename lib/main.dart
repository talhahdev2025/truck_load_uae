import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truck_loads_uae/firebase_options.dart';
import 'src/core/constants/app_constants.dart';
import 'src/core/theme/app_theme.dart';
import 'src/features/home/presentation/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
