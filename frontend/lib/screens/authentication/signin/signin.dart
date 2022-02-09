// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

import '../signup/signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ameyroo',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 24),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(height: 30),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(20.0)),
                ),
                suffixIcon: const Icon(Icons.email),
                hintText: 'Enter your email',
                labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter e-mail';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20.0)),
                  ),
                  suffixIcon: const Icon(Icons.visibility),
                  hintText: 'Enter your password',
                  labelText: 'Password')),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              //forgot password screen
            },
            child: const Text(
              'Forgot Password?',
            ),
          ),
          Row(
            children: <Widget>[
              FloatingActionButton.extended(
                label: const Text('Sign In'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(height: 30),
          Row(
            children: <Widget>[
              FloatingActionButton.extended(
                icon: Image.asset('assets/images/google.jpeg',
                    height: 20, width: 30),
                label: const Text('Sign in with Google'),
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 14, 10, 10),
                onPressed: () {},
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: <Widget>[
              FloatingActionButton.extended(
                icon: Image.asset('assets/images/apple.png',
                    height: 20, width: 30),
                label: const Text('Sign in with Apple'),
                backgroundColor: Colors.black,
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                onPressed: () {},
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(height: 28),
          Row(
            children: <Widget>[
              const Text("Don't have an account?"),
              TextButton(
                child: const Text(
                  'Register here',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  //signup screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ]),
      ),
    );
  }
}
