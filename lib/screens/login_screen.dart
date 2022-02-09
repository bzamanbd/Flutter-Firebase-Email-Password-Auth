import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
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
                    keyboardType: TextInputType.emailAddress,
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
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    obscuringCharacter: '#',
                    controller: passController,
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  loading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (emailController.text == "" ||
                                    passController.text == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('All fields are required')));
                                } else {
                                  User? result = await AuthService().login(
                                      emailController.text,
                                      passController.text,
                                      context);
                                  if (result != null) {
                                    // ignore: avoid_print
                                    print(result.email);
                                  }
                                  // ignore: avoid_print
                                  print('success');
                                }
                                setState(() {
                                  loading = false;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height / 30,
                                  horizontal: 0,
                                ),
                                child: const Text('Login'),
                              )),
                        ),
                  SizedBox(
                    height: size.height / 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('For a new account'),
                      TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/signup'),
                          child: const Text('SignUp'))
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
