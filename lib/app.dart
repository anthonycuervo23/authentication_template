import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//My imports
import 'package:authentication_template/core/analytics.dart';
import 'package:authentication_template/core/providers.dart';
import 'package:authentication_template/core/routes.dart';
import 'package:authentication_template/core/themes.dart';
import 'package:authentication_template/features/auth/presentation/pages/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppThemes.context = context;
    return Consumer(builder: (context, watch, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.defaultTheme,
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: watch(analyticsProvider),
            nameExtractor: analyticsNameExtractor,
          )
        ],
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: AuthHomePage(),
      );
    });
  }
}
