import 'package:daily_planner_firebase_bloc/domain/services/firebase_authentication.dart';
import 'package:daily_planner_firebase_bloc/ui/navigation/main_navigation.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/auth_widget/auth_view_cubit.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class _AuthData {
  String login = '';
  String password = '';
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _onAuthViewCubitStateChanges(
    BuildContext context,
    AuthViewCubitState state,
  ) {
    if (state is AuthViewCubitSuccessState) {
      MainNavigation.resetNavigation(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authentication = FirebaseAuthentication();
    return BlocListener<AuthViewCubit, AuthViewCubitState>(
      listener: _onAuthViewCubitStateChanges,
      child: Provider(
        create: (_) => _AuthData(),
        child: Forms(
          authentication: authentication,
        ),
      ),
    );
  }
}

class Forms extends StatelessWidget {
  const Forms({
    super.key,
    required FirebaseAuthentication authentication,
  }) : _authentication = authentication;

  final FirebaseAuthentication _authentication;

  @override
  Widget build(BuildContext context) {
    final authData = context.read<_AuthData>();

    final List<Widget> textFields = [
      CustomTextField(onChanged: (text) => authData.login, label: 'Email'),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(onChanged: (text) => authData.login, label: 'Password'),
    ];

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 150),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 80.0),
                    child: Text(
                      'Login page',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Column(
                    children: [
                      ...textFields,
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _authentication.signInWithEmailAndPassword(
                          authData.login,
                          authData.password,
                        );
                      },
                      child: const Text('Log in'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do not have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/registration');
                          },
                          child: const Text('Register'))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
