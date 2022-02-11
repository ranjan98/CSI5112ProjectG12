import 'package:flutter/material.dart';

class EmailSent extends StatelessWidget {
  // function to render out the items in the drawer

  const EmailSent({Key? key}) : super(key: key);

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
              'Email has been sent',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 30),

            // forgot password description
            const Center(
                child: SizedBox(
                    width: 300,
                    child: Text(
                      'Please check your inbox and click on the recieved link to reset a password',
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ))),

            // forgot password - send email pic
            const Image(
                image: AssetImage('assets/images/receivedemail.png'),
                height: 300,
                width: 300),

            // recovery email emailAddress

            const SizedBox(height: 15),
            // FloatingActionButton.extended(
            //   label: Text('Sign In'),
            //   onPressed: () {
            //     Navigator.of(context).pushNamed('/home');
            //   },
            // ),
            FloatingActionButton.extended(
              label: const Text('Login'),
              onPressed: () {
                Navigator.of(context).pushNamed('/signin');
              },
            ),

            Row(
              children: <Widget>[
                const Text("Didn't receive an email?"),
                TextButton(
                  child: const Text(
                    'Resend',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.of(context).pushNamed('/orderplaced');
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
