import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  // function to render out the items in the drawer

  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Ameyroo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            // show the basic details for the user via the header
            const SizedBox(height: 60),

            // forgot password title
            const Center(
                child: Text(
              'Forgot your password?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 30),

            // forgot password description
            const Center(
                child: SizedBox(
                    width: 300,
                    child: Text(
                      'Enter your registered email to receive instructions to reset password',
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ))),

            // forgot password - send email pic
            const Image(
                image: AssetImage('assets/images/sendemail.png'),
                height: 300,
                width: 400),

            // recovery email emailAddress

            const Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      suffixIcon: Icon(Icons.email),
                      hintText: 'Enter your email',
                      labelText: 'Email'),
                )),

            const SizedBox(height: 15),
            // FloatingActionButton.extended(
            //   label: Text('Sign In'),
            //   onPressed: () {
            //     Navigator.of(context).pushNamed('/home');
            //   },
            // ),
            FloatingActionButton.extended(
              label: const Text('Send'),
              onPressed: () {
                Navigator.of(context).pushNamed('/emailsent');
              },
            ),
          ],
        ));
  }
}
