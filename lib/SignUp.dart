import 'dart:developer';

import 'package:api_start/Controller/SignUpController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  final SignUpController signupcontroller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: signupcontroller.emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: signupcontroller.passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  signupcontroller.SignUp(signupcontroller.emailController.text,
                      signupcontroller.passwordController.text);
                  log(signupcontroller.emailController.text.toString());
                  log(signupcontroller.passwordController.text.toString());
                },
                child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
