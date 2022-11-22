import 'package:flutter/material.dart';
import 'package:ncrypt/screens/home_screen.dart';
import 'package:ncrypt/screens/login_screen.dart';
import 'package:ncrypt/screens/signup_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/':(route) => MaterialPage(child:LoginScreen()),
  '/signup':(route) => const MaterialPage(child: SignupScreen())
});

final loggedInRoute = RouteMap(routes: {
  '/':(route) => const MaterialPage(child: HomeScreen()),
});