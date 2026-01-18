import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/services/notification_service.dart';
import 'firebase_options.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

    // Initialize Hive for local storage
    await Hive.initFlutter();

    // Initialize notifications
    await NotificationService.instance.initialize();

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
          const SystemUIOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Colors.white,
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
        );

    runApp(const ProviderScope(child: EGetApp()));
}

class EGetApp extends ConsumerWidget {
    const EGetApp({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
          final router = ref.watch(appRouterProvider);

          return MaterialApp.router(
                  title: 'EGet - Assistente de Finanças',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: ThemeMode.light,
                  routerConfig: router,
                );
    }
}
