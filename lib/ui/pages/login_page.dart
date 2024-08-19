import 'package:daily_planner_firebase_bloc/route_names.dart';
import 'package:daily_planner_firebase_bloc/ui/navigation/main_navigation.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/auth_widget/auth_view_cubit.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/auth_widget/auth_view_cubit_state.dart';
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
    return BlocListener<AuthViewCubit, AuthViewCubitState>(
      listener: _onAuthViewCubitStateChanges,
      child: Provider(
        create: (_) => _AuthData(),
        child: const Forms(),
      ),
    );
  }
}

class Forms extends StatelessWidget {
  const Forms({super.key});

  @override
  Widget build(BuildContext context) {
    final authData = context.read<_AuthData>();
    final cubit = context.watch<AuthViewCubit>();
    final canStartAuth = cubit.state is AuthViewCubitInProgressState ||
        cubit.state is AuthViewCubitErrorState;
    onPressed() {
      if (canStartAuth) {
        cubit.auth(login: authData.login, password: authData.password);
        cubit.state is AuthViewCubitSuccessState
            ? Navigator.pushNamed(context, RouteNames.mainScreen)
            : null;
      }
    }
    final List<Widget> textFields = [
      CustomTextField(
          onChanged: (text) => authData.login = text, label: 'Email'),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(
          onChanged: (text) => authData.password = text, label: 'Password'),
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
                      onPressed: onPressed,
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

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((AuthViewCubit c) {
      final state = c.state;
      return state is AuthViewCubitErrorState ? state.errorMessage : null;
    });

    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(fontSize: 17, color: Colors.red),
      ),
    );
  }
}
