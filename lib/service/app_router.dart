import 'dart:developer';

import 'package:chitchat/app/splash_screen.dart';
import 'package:chitchat/utils/constants/k_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationClass {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
}

class KNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // log('${route.currentResult}', name: "Did Push Route");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // log('${route.currentResult}', name: "Did Pop Route");
  }
}

final goRouting = Provider<GoRouter>((ref) {
  GlobalKey<NavigatorState> navigationKey = NavigationClass.navigationKey;
  // GlobalKey<NavigatorState>();
  return GoRouter(
    initialLocation: "/",
    navigatorKey: navigationKey,
    observers: [
      KNavigatorObserver(),
    ],
    routes: <RouteBase>[
      GoRoute(
        name: KRoutes.splashScreen,
        path: '/',
        builder: (context, state) {
          log("parameters :${state.pathParameters} :: Extra: ${state.extra}",
              name: "GoRouter - Splash");
          return const SplashScreen();
        },
      ),
      /* GoRoute(
        name: KRoutes.signInScreen,
        path: KRoutes.signInScreen,
        pageBuilder: (context, state) {
          log("parameters :${state.pathParameters} :: Extra: ${state.extra}",
              name: "GoRouter - Auth");
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SignInScreen(),
            name: KRoutes.signInScreen,
            barrierDismissible: false,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 0,
                  child: child,
                ),
              );
            },
          );
        },
      ), */
      /* GoRoute(
        name: KRoutes.signUpScreen,
        path: KRoutes.signUpScreen,
        pageBuilder: (context, state) {
          log("parameters :${state.pathParameters} :: Extra: ${state.extra}",
              name: "GoRouter - Sign Up Screen");
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SingUpScreen(),
            name: KRoutes.signUpScreen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              Animatable<Offset> tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              Animation<Offset> offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ), */
    ],
  );
});
