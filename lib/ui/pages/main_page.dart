import 'package:daily_planner_firebase_bloc/route_names.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, RouteNames.loginPage);
            },
            child: const Text('ok')),
      ),
    );
  }
}
