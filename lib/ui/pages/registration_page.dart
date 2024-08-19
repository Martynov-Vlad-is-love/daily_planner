import 'package:daily_planner_firebase_bloc/domain/services/firebase_authentication.dart';
import 'package:daily_planner_firebase_bloc/route_names.dart';
import 'package:daily_planner_firebase_bloc/ui/navigation/main_navigation.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/auth_widget/auth_view_cubit.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/auth_widget/auth_view_cubit_state.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class _RegistrationData {
  String login = '';
  String password = '';
  String repeatedPassword = '';
}

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

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
        create: (_) => _RegistrationData(),
        child: const Forms(),
      ),
    );
  }
}

class Forms extends StatelessWidget {
  const Forms({super.key});

  bool isEqual(String password, String repeatPassword) =>
      password == repeatPassword;

  @override
  Widget build(BuildContext context) {
    final authData = context.read<_RegistrationData>();
    final cubit = context.watch<AuthViewCubit>();
    final canStartAuth = cubit.state is AuthViewCubitInProgressState ||
        cubit.state is! AuthViewCubitErrorState;
    onPressed() {
      if (canStartAuth && isEqual(authData.password, authData.repeatedPassword)) {
        cubit.register(login: authData.login, password: authData.password);
        cubit.state is AuthViewCubitSuccessState
            ? cubit.auth(login: authData.login, password: authData.password)
            : null;
        cubit.state is AuthViewCubitSuccessState
            ? Navigator.pushNamed(context, RouteNames.mainScreen)
            : null;
      }
    }

    final registrationData = context.read<_RegistrationData>();
    final List<Widget> textFields = [
      CustomTextField(
          onChanged: (text) => registrationData.login, label: 'Email'),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(
          onChanged: (text) => registrationData.password, label: 'Password'),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(
          onChanged: (text) => registrationData.repeatedPassword,
          label: 'Repeat password'),
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
                      'Registration page',
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
                      child: const Text('Register'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have an account?'),
                      TextButton(
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Back to login page'))
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
