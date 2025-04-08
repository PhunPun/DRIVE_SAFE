import 'package:drive_safe/Pages/home/home_page.dart';
import 'package:drive_safe/Pages/login/login_page.dart';
import 'package:drive_safe/Pages/register/register_page.dart';
import 'package:drive_safe/Pages/welcome/welcome_page.dart';
import 'package:drive_safe/apps/router/router_name.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:drive_safe/Pages/drowsiness/drowsiness_screen.dart';
import 'package:camera/camera.dart';
import 'package:drive_safe/main.dart';


class RouterCustum{
  static final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: RouterName.welcome,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          name: RouterName.login,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: 'register',
          name: RouterName.register,
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterPage();
          },
        ),
      ],
    ),
  ],
);
}