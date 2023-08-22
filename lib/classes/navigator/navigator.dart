import 'package:flutter/material.dart';

class AppNavigator {
  appAnimationNavigator(BuildContext context, Widget screen) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => screen,
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ));
  }
}
