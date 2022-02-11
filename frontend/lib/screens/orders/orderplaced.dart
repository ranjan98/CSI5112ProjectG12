import 'package:flutter/material.dart';

class OrderPlaced extends StatelessWidget {
  // function to render out the items in the drawer

  const OrderPlaced({Key? key}) : super(key: key);

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
              'Thank you!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),

            const Image(
                image: AssetImage('assets/images/orderplaced.png'),
                height: 350,
                width: 300),
            // forgot password description
            const Center(
                child: SizedBox(
                    width: 300,
                    child: Text(
                      'Your order has been placed.',
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ))),
            const SizedBox(height: 2),
            const Center(
                child: SizedBox(
                    width: 300,
                    child: Text(
                      'Order No# 3453242',
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ))),
            // forgot password - send email pic

            // recovery email emailAddress

            const SizedBox(height: 15),
            // FloatingActionButton.extended(
            //   label: Text('Sign In'),
            //   onPressed: () {
            //     Navigator.of(context).pushNamed('/home');
            //   },
            // ),

            Row(
              children: <Widget>[
                FloatingActionButton.extended(
                  icon: const Icon(Icons.print),
                  label: const Text('Print Invoice'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/emailsent');
                  },
                ),
                const SizedBox(width: 10),
                FloatingActionButton.extended(
                  icon: const Icon(Icons.email),
                  label: const Text('Email Receipt'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/emailsent');
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                FloatingActionButton.extended(
                  label: const Text('Continue shopping'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home');
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
