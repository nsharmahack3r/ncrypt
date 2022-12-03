import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ncrypt/screens/chat_screen.dart';
import 'package:ncrypt/screens/find_users.dart';
import 'package:ncrypt/screens/home_screen.dart';
import 'package:ncrypt/screens/login_screen.dart';
import 'package:ncrypt/screens/signup_screen.dart';

import 'models/user.dart';
final GoRouter authRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/findUsers",
      builder: (context, state) => const FindUsers(),
    ),
    GoRoute(
      path: "/chat",
      builder: (context, state) {
        return ChatScreen(user: state.extra as User);
      }
    )
  ],
);
final GoRouter noAuthRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: "/signup",
      builder: (context, state) => const SignupScreen(),
    ),
  ],
);