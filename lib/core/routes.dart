import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//My imports
import 'package:authentication_template/features/auth/presentation/pages/home.dart';
import 'package:authentication_template/features/auth/presentation/pages/splash.dart';
import 'package:authentication_template/features/auth/presentation/pages/user_info.dart';

class AppRoutes {
  static const home = "/";
  static const splash = "splash";
  static const login = "login";
  static const signup = "signup";
  static const userInfo = "user_info";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
            case home:
              return AuthHomePage();
            case userInfo:
              return UserInfoPage();
            case splash:
            default:
              return Splash();
          }
        });
  }
}
