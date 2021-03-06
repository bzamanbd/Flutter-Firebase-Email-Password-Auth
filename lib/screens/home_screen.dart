import 'package:firebase_first_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await AuthService().logOut(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: TextButton.styleFrom(primary: Colors.white)),
          ],
        ),
        body: const Center(
          child: Text('this is homepage'),
        ),
      ),
    );
  }
}
