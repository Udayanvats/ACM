// ignore_for_file: prefer_const_constructors

import 'package:acm/constants/routes.dart';
import 'package:acm/views/background.dart';
import 'package:acm/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isPasswordHidden = true;
  late final TextEditingController _email;

  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'REGISTER\nHERE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: 'Email', prefixIcon: Icon(Icons.email)),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  controller: _email,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: isPasswordHidden,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _password,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.security),
                    suffixIcon: InkWell(
                      onTap: togglePassword,
                      child: Icon(
                        isPasswordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                        final user = FirebaseAuth.instance.currentUser;
                        await user?.sendEmailVerification();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushNamed(verifyRoute);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          await showErrorDialog(context, 'User Not Found');
                        } else if (e.code == 'wrong-password') {
                          await showErrorDialog(context, 'Wrong Password');
                        } else if (e.code == 'email-already-in-use') {
                          await showErrorDialog(
                              context, 'Email Already Registered');
                        } else if (e.code == 'weak-password') {
                          await showErrorDialog(context, 'Weak Password');
                        }
                      }
                    },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ])),
                        child: const Center(
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Already Registered?"),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  },
                  child: const Center(child: Text("Login Here"))),
            ],
          ),
        ),
      ),
    );
  }

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    setState(() {});
  }
}
