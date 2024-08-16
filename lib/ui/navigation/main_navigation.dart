import 'package:daily_planner_firebase_bloc/domain/factories/screen_factory.dart';
import 'package:daily_planner_firebase_bloc/route_names.dart';
import 'package:flutter/cupertino.dart';

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    RouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    RouteNames.loginPage: (_) => _screenFactory.makeAuth(),
    RouteNames.mainScreen: (_) => _screenFactory.makeMainScreen()
  };

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.loaderWidget,
      (route) => false,
    );
  }
}
