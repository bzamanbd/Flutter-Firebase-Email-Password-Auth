// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var cnfPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width / 30,
                vertical: 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      hintText: 'Enter Email Address',
                      border: OutlineInputBorder(),
                    ),
                    controller: emailController,
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Password'),
                      hintText: 'Enter a password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: passController,
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Confirm Password'),
                      hintText: 'Confirm your password',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: cnfPassController,
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (emailController.text == "" ||
                              passController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('All fields are required')));
                          } else if (passController.text !=
                              cnfPassController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("password didn't match")));
                          } else {
                            User? result = await AuthService().register(
                                emailController.text, passController.text);
                            if (result != null) {
                              print(result.email);
                            }
                            print('success');
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height / 30,
                            horizontal: 0,
                          ),
                          child: const Text('SignUp'),
                        )),
                  ),
                  SizedBox(
                    height: size.height / 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/login'),
                          child: const Text('Login'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
