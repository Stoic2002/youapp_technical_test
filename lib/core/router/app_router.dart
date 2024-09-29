import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_technical_test/data/models/profile_model.dart';
import 'package:youapp_technical_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:youapp_technical_test/presentation/pages/interest_page.dart';
import 'package:youapp_technical_test/presentation/pages/login_page.dart';
import 'package:youapp_technical_test/presentation/pages/profile_page.dart';
import 'package:youapp_technical_test/presentation/pages/register_page.dart';

class AppRouter {
  static GoRouter get router {
    return GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/interest',
          builder: (context, state) {
            final profile = state.extra as ProfileModel;
            return InterestPage(profile: profile);
          },
        ),
      ],
      redirect: (context, state) {
        final authState = context.read<AuthBloc>().state;

        if (authState is AuthAuthenticated) {
          return null;
        } else if (state.matchedLocation == '/profile') {
          return '/login';
        }
        return null;
      },
    );
  }
}
