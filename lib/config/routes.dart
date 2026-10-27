import 'package:anime_verse/screens/about_screen.dart';
import 'package:anime_verse/screens/change_password_screen.dart';
import 'package:anime_verse/screens/change_username_screen.dart';
import 'package:anime_verse/screens/favorite_screen.dart';
import 'package:anime_verse/screens/forgot_password_screen.dart';
import 'package:anime_verse/screens/home_screen.dart';
import 'package:anime_verse/screens/profile_screen.dart';
import 'package:anime_verse/screens/signin_screen.dart';
import 'package:anime_verse/screens/signup_screen.dart';
import 'package:anime_verse/widgets/bottom_navigation_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/dummy_data.dart'; // sesuaikan path-nya

import '../screens/detail_screen.dart';

class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String changeUsername = '/change-username';
  static const String changePassword = '/change-password';
  static const String about = '/about';
  static const String details = '/details';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.signIn,
    routes: [
      // 1. Auth Routes
      GoRoute(
        path: AppRoutes.signIn,
        name: 'sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // 2. Detail Route
      GoRoute(
        path: '${AppRoutes.details}/:id',
        name: 'detail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final animeId = state.pathParameters['id'] ?? '';
          final anime = DummyData.findById(animeId);
          return DetailScreen(anime: anime);
        },
      ),

      // Profile sub-pages (tampil full screen, di atas bottom navigation)
      GoRoute(
        path: AppRoutes.changeUsername,
        name: 'change-username',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ChangeUsernameScreen(
          currentUsername: state.extra as String? ?? 'username',
        ),
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        name: 'change-password',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.about,
        name: 'about',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AboutScreen(),
      ),

      // 3. ShellRoute (Untuk Halaman yang menggunakan Bottom Navigation Bar)
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return BottomNavigationShell(navigationShell: child);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                name: 'favorite',
                builder: (context, state) => const FavoriteScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
