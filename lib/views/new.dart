// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:acm/constants/routes.dart';
import 'package:acm/views/background.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:phone_number/phone_number.dart';

class NewView extends StatelessWidget {
  NewView({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
            child: Form(
          key: formKey,
          child: Column(children: [
            Positioned(
              top: 150,
              left: 14,
              child: Padding(
                padding: const EdgeInsets.only(top: 100, right: 165),
                child: Text(
                  "Welcome !",
                  style: TextStyle(
                      fontSize: 35,
                      color: Color(0xFF363f93),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter your name",
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Enter Correct Name";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 25, left: 25),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter your phone number",
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^([6-9]\d{9}$)').hasMatch(value)) {
                    return ("Enter correct phone number");
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 25, left: 25),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter your age",
                ),
                validator: (value) {
                  int? age = int.tryParse(value!);
                  if (age == null || age <= 0) {
                    return 'Age must be greater then 0';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 25, left: 25),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Date of Birth[dd/mm/yyyy]",
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^((0[1-9]|1[0-9]|2[0-9]|3[012])[/](0[1-9]|1[012])[/](19|20)\d\d)+$')
                          .hasMatch(value)) {
                    return "Enter Correct Date Of Birth";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 150,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            gridRoute, (route) => false);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Processing Data')),
                        // );
                      }
                    },
                    child: Text("Save"))
              ],
            ),
          ]),
        )),
      ),
    );
  }
}
