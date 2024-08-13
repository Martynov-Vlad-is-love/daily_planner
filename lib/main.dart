import 'package:daily_planner_firebase_bloc/ui/pages/login_page.dart';
import 'package:daily_planner_firebase_bloc/storage/object_box.dart';
import 'package:daily_planner_firebase_bloc/ui/pages/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt objectBox = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  objectBox
      .registerSingletonAsync<ObjectBox>(() async => await ObjectBox.create());
  runApp(
    MaterialApp(
      home: const LoginPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginPage(),
        '/registration': (BuildContext context) => const RegistrationPage(),
      },
    ),
  );
}
