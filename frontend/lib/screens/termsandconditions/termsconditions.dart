// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

import '../authentication/signup/signup.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UOMart',
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
                "Terms and Conditions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  decorationColor: Colors.red,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(height: 30),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Expanded(
                  child: Text(
                      'These Terms of Use constitute a legally binding agreement made between you, whether personally or on behalf of an entity (“you”) and [business entity name] (“we,” “us” or “our”), concerning your access to and use of the [website name.com] website as well as any other media form, media channel, mobile website or mobile application related, linked, or otherwise connected thereto (collectively, the “Site”).',
                      textAlign: TextAlign.justify))),
          const SizedBox(height: 30),
          Row(
            children: <Widget>[
              FloatingActionButton.extended(
                label: const Text('Return back to Signup'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ]),
      ),
    );
  }
}
