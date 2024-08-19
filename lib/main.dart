import 'package:daily_planner_firebase_bloc/route_names.dart';
import 'package:daily_planner_firebase_bloc/ui/navigation/main_navigation.dart';
import 'package:daily_planner_firebase_bloc/ui/pages/login_page.dart';
import 'package:daily_planner_firebase_bloc/storage/object_box.dart';
import 'package:daily_planner_firebase_bloc/ui/pages/main_page.dart';
import 'package:daily_planner_firebase_bloc/ui/pages/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

GetIt objectBox = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  objectBox
      .registerSingletonAsync<ObjectBox>(() async => await ObjectBox.create());
  runApp(
    MaterialApp(
      initialRoute: RouteNames.loginPage,
      routes: MainNavigation.routes
    ),
  );
}
