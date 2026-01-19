import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/goals/presentation/screens/goals_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../shell/main_shell.dart';

/// App Router Provider
final appRouterProvider = Provider<GoRouter>((ref) {
    return GoRouter(
          initialLocation: '/login',
          debugLogDiagnostics: true,
          routes: [
                  // Auth Routes
                  GoRoute(
                            path: '/login',
                            name: 'login',
                            builder: (context, state) => const LoginScreen(),
                          ),
                  GoRoute(
                            path: '/register',
                            name: 'register',
                            builder: (context, state) => const RegisterScreen(),
                          ),
                  GoRoute(
                            path: '/forgot-password',
                            name: 'forgot-password',
                            builder: (context, state) => const ForgotPasswordScreen(),
                          ),

                  // Onboarding
                  GoRoute(
                            path: '/onboarding',
                            name: 'onboarding',
                            builder: (context, state) => const OnboardingScreen(),
                          ),

                  // Main App Shell with Bottom Navigation
                  ShellRoute(
                            builder: (context, state, child) => MainShell(child: child),
                            routes: [
                                        GoRoute(
                                                      path: '/home',
                                                      name: 'home',
                                                      pageBuilder: (context, state) => CustomTransitionPage(
                                                                      child: const HomeScreen(),
                                                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                                                        return FadeTransition(opacity: animation, child: child);
                                                                      },
                                                                    ),
                                                    ),
                                        GoRoute(
                                                      path: '/history',
                                                      name: 'history',
                                                      pageBuilder: (context, state) => CustomTransitionPage(
                                                                      child: const HistoryScreen(),
                                                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                                                        return FadeTransition(opacity: animation, child: child);
                                                                      },
                                                                    ),
                                                    ),
                                        GoRoute(
                                                      path: '/reports',
                                                      name: 'reports',
                                                      pageBuilder: (context, state) => CustomTransitionPage(
                                                                      child: const ReportsScreen(),
                                                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                                                        return FadeTransition(opacity: animation, child: child);
                                                                      },
                                                                    ),
                                                    ),
                                        GoRoute(
                                                      path: '/goals',
                                                      name: 'goals',
                                                      pageBuilder: (context, state) => CustomTransitionPage(
                                                                      child: const GoalsScreen(),
                                                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                                                        return FadeTransition(opacity: animation, child: child);
                                                                      },
                                                                    ),
                                                    ),
                                        GoRoute(
                                                      path: '/settings',
                                                      name: 'settings',
                                                      pageBuilder: (context, state) => CustomTransitionPage(
                                                                      child: const SettingsScreen(),
                                                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                                                        return FadeTransition(opacity: animation, child: child);
                                                                      },
                                                                    ),
                                                    ),
                                      ],
                          ),
                ],
          errorBuilder: (context, state) => Scaffold(
                  body: Center(
                            child: Text('Page not found: ${state.uri.path}'),
                          ),
                ),
        );
});
