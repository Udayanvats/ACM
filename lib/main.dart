// ignore_for_file: unnecessary_string_escapes, prefer_const_constructors

import 'package:acm/constants/routes.dart';
import 'package:acm/firebase_options.dart';
import 'package:acm/services/service.dart';
import 'package:acm/views/email.dart';
import 'package:acm/views/grid.dart';
import 'package:acm/views/login.dart';
import 'package:acm/views/new.dart';
import 'package:acm/views/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ACM',
      theme: ThemeData(
        primaryColor: Color(0xFF2661FA),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Homepage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        newRoute: (context) => NewView(),
        verifyRoute: (context) => const VerifyEmailView(),
        gridRoute: (context) => const gird(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  print("Email is Verified");
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
              return const LoginView();
            default:
              return const LinearProgressIndicator();
          }
        });
  }
}
