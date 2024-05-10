import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:read/auth/login.dart';
import 'package:read/screen/homepage.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          } else {
            if (snapshot.hasData) {
              return const Homepage();
            } else {
              return const Login();
            }
          }
        },
      ),
    );
  }
}
