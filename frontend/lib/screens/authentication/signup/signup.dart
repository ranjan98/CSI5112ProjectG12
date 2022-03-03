// ignore_for_file: unnecessary_const
import 'package:flutter/material.dart';

import '../../termsandconditions/termsconditions.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showPassword = true;
  bool showRePassword = true;
  IconData visibility = Icons.visibility;
  IconData visibilityRe = Icons.visibility;

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
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
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const Text(
                '(or)',
                style: TextStyle(fontSize: 18),
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
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              suffixIcon: Icon(Icons.email),
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter e-mail';
              }
              return null;
            },
          ),
          const SizedBox(height: 6),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              suffixIcon: Icon(Icons.mobile_screen_share),
              hintText: 'Enter your mobile number',
              labelText: 'Mobile',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter mobile number';
              }
              return null;
            },
          ),
          const SizedBox(height: 6),
          TextFormField(
              obscureText: showPassword,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                        visibility == Icons.visibility
                            ? visibility = Icons.visibility_off
                            : visibility = Icons.visibility;
                      });
                    },
                    child: Icon(visibility),
                  ),
                  hintText: 'Enter your password',
                  labelText: 'Password')),
          const SizedBox(height: 6),
          TextFormField(
              obscureText: showRePassword,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20.0)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        showRePassword = !showRePassword;
                        visibilityRe == Icons.visibility
                            ? visibilityRe = Icons.visibility_off
                            : visibilityRe = Icons.visibility;
                      });
                    },
                    child: Icon(visibilityRe),
                  ),
                  hintText: 'Re-enter your password',
                  labelText: 'Re-enter password')),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              const Text("I agree to the"),
              TextButton(
                child: const Text(
                  'terms and conditions',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  //signup screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsConditions()));
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: <Widget>[
              FloatingActionButton.extended(
                label: const Text('Sign Up'),
                onPressed: () {},
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }
}
