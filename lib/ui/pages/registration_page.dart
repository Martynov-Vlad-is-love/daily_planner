import 'package:daily_planner_firebase_bloc/domain/services/firebase_authentication.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final repeatPasswordController = TextEditingController(text: '');

  final _authentication = FirebaseAuthentication();

  @override
  Widget build(BuildContext context) {
    List<Widget> textFields = [
      CustomTextField(emailController: emailController, label: 'Email'),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(emailController: passwordController, label: 'Password'),
      CustomTextField(emailController: repeatPasswordController, label: 'Repeat password'),

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
                      onPressed: () async{
                        if (passwordController.text ==
                            repeatPasswordController.text) {
                          final user =
                              await _authentication.signUpWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text);
                          if(user != null){
                            print('Success');
                          }
                          else{
                            print('Failure');
                          }
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do not have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
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
