import 'package:daily_planner_firebase_bloc/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    List<Widget> textFields = [
      CustomTextField(emailController: emailController, label: 'Email'),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(emailController: passwordController, label: 'Password'),
    ];

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
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
                      onPressed: () {},
                      child: const Text('Log in'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do not have an account?'),
                      TextButton(
                          onPressed: () {}, child: const Text('Register'))
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
