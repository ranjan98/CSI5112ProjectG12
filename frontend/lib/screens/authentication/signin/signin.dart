import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 20,
          child: const Text('Hello', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
