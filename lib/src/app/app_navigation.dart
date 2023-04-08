import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:itfox_test_project/src/app/cubit/app_cubit.dart';
import 'package:itfox_test_project/src/domain/repositories/authentication_repository.dart';
import 'package:itfox_test_project/src/domain/repositories/weather_repository.dart';
import 'package:itfox_test_project/src/pages/login_page/cubit/log_in_page_cubit.dart';
import 'package:itfox_test_project/src/pages/login_page/ui/log_in_page.dart';
import 'package:itfox_test_project/src/pages/signup_page/cubit/sign_up_page_cubit.dart';
import 'package:itfox_test_project/src/pages/signup_page/ui/sign_up_page.dart';
import 'package:itfox_test_project/src/pages/weather_page/ui/weather_page.dart';

import '../pages/profile_page/ui/profile_page.dart';
import '../pages/weather_page/cubit/weather_page_cubit.dart';

abstract class AppNavigation {
  static GoRouter getRouter({required BuildContext context}) {
    return GoRouter(
      initialLocation: context.watch<AppCubit>().state is AppAuthenticatedState
          ? '/weather'
          : context.read<AppCubit>().state is AppUnAuthenticatedState
              ? '/login'
              : '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(),
          routes: [
            GoRoute(
              path: 'login',
              name: 'login',
              pageBuilder: (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create: (context) => LogInPageCubit(
                    authenticationRepository:
                        context.read<AuthenticationRepository>(),
                  ),
                  child: const LogInPageWidget(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 270),
              ),
            ),
            GoRoute(
              path: 'signup',
              name: 'signup',
              pageBuilder: (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create: (context) => SignUpPageCubit(
                    authenticationRepository:
                        context.read<AuthenticationRepository>(),
                  ),
                  child: const SignUpPageWidget(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 270),
              ),
            ),
            GoRoute(
              path: 'weather',
              name: 'weather',
              pageBuilder: (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create: (context) => WeatherPageCubit(
                    weatherRepository: context.read<WeatherRepository>(),
                  ),
                  lazy: false,
                  child: const WeatherPageWidget(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 270),
              ),
            ),
            GoRoute(
              path: 'profile',
              name: 'profile',
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const ProfilePageWidget(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 270),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
