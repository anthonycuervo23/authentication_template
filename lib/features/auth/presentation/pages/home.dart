import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//My imports
import 'package:authentication_template/core/analytics.dart';
import 'package:authentication_template/core/providers.dart';
import 'package:authentication_template/features/auth/model/user_repository.dart';
import 'package:authentication_template/features/auth/presentation/pages/login.dart';
import 'package:authentication_template/features/auth/presentation/pages/splash.dart';
import 'package:authentication_template/features/home/presentation/pages/home.dart';
import 'package:authentication_template/onboarding/presentation/pages/intro.dart';

class AuthHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final user = watch(userRepoProvider);
        switch (user.status) {
          case Status.Unauthenticated:
          case Status.Authenticating:
            setCurrentScreen(context, AnalyticsScreenNames.welcome);
            return WelcomePage();
          case Status.Authenticated:
            setUserProperties(context,
                id: user.fbUser?.uid,
                name: user.fbUser?.displayName,
                email: user.fbUser?.email);
            setCurrentScreen(context, AnalyticsScreenNames.userInfo);
            if (user.isLoading) return Splash();
            return user.user?.introSeen ?? false ? HomePage() : IntroPage();
          case Status.Uninitialized:
          default:
            setCurrentScreen(context, AnalyticsScreenNames.splash);
            return Splash();
        }
      },
    );
  }
}
