import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_state.dart';
import 'package:daily_planner_firebase_bloc/domain/services/firebase_authentication.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/custom_text_field.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/loader_widget/loader_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  final _authentication = FirebaseAuthentication();

  AuthBloc? _authBloc;

  @override
  Widget build(BuildContext context) {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    List<Widget> textFields = [
      CustomTextField(emailController: emailController, label: 'Email'),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(emailController: passwordController, label: 'Password'),
    ];

    return BlocProvider<LoaderViewCubit>(
      create: (context) =>
          LoaderViewCubit(LoaderViewCubitState.unknown, authBloc),
      lazy: false,
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 150),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 80.0),
                      child: Text(
                        'Login page',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
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
                        onPressed: () {
                          _authentication.signInWithEmailAndPassword(
                              emailController.text, passwordController.text);
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
      ),
    );
  }
}
