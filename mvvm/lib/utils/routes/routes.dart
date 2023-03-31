import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/sign_up_view.dart';
import 'package:mvvm/view/splash_view.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (context) => SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (context) => LoginScreen());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (context) => HomeScreen());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (context) => SignUpView());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Define'),
            ),
          );
        });
    }
  }
}







