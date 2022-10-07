// ignore_for_file: use_build_context_synchronously

import 'package:acm/constants/routes.dart';
import 'package:acm/services/authservice.dart';
import 'package:acm/views/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,

        // appBar: AppBar(title: const Text('Login')),

        body: SingleChildScrollView(
          child: Background(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  // ignore: prefer_const_constructors
                  child: Text(
                    "LOGIN",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 50),
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
                const SizedBox(height: 20),
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
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 25,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email, password: password);
                        final user = FirebaseAuth.instance.currentUser;
                        if (user?.emailVerified ?? false) {
                          // ignore
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              newRoute, (route) => false);
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyRoute, (route) => false);
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          await showErrorDialog(context, 'User Not found');
                        } else if (e.code == 'wrong-password') {
                          await showErrorDialog(context, 'Wrong Password');
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
                            gradient: new LinearGradient(colors: [
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ])),
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 130, vertical: 5),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          height: 2,
                          color: Color(0xFF2661FA),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 2,
                          color: Color(0xFF2661FA),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FloatingActionButton.extended(
                    onPressed: () {
                      AuthService().signInWithGoogle();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(newRoute, (route) => false);
                    },
                    label: const Text('Login With Google'),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    icon: const ImageIcon(
                      AssetImage('assets/image/google.jpg'),
                    )),

                const SizedBox(height: 5),
                // FloatingActionButton.extended(
                //     onPressed: () {
                //       AuthService().signOut();
                //     },
                //     label: Text('Login With Google'),
                //     backgroundColor: Colors.white,
                //     foregroundColor: Colors.black,
                //     icon: ImageIcon(
                //       AssetImage('assets/image/google.jpg'),
                //     )),

                // ignore: prefer_const_constructors
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                  child: const Text("Haven't Registered Yet?"),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute, (route) => false);
                    },
                    child: const Center(child: Text("Register Here"))),
              ])),
        ));
  }

  void togglePassword() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }
}

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Error:'),
            content: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay')),
            ]);
      });
}
