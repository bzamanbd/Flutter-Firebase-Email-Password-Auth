import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_first_app/screens/signup_screen.dart';
import 'package:firebase_first_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String _title = 'Email Auth';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(title: _title);
            // return const SignupScreen();
          }
          return const SignupScreen();
        },
        stream: AuthService().firebaseAuth.authStateChanges(),
      ),
      routes: {
        '/home': (_) => HomeScreen(title: _title),
        '/signup': (_) => const SignupScreen(),
        '/login': (_) => const LoginScreen(),
      },
    );
  }
}
