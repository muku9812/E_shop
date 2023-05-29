import 'package:flutter/material.dart';
import 'package:practise/services/splashServices.dart';
import 'package:practise/utilities/routes/routesName.dart';
import 'package:practise/view/contactUs.dart';
import 'package:practise/view/homeView.dart';
import 'package:practise/view/registerView.dart';
import 'package:practise/view/splashScreen.dart';

import '../../view/loginView.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());
      case RoutesName.contact:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ContactUs());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterView());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined."),
            ),
          );
        });
    }
  }
}
