import 'package:flutter/material.dart';
import 'package:frontend/screens/authentication/forgotpassword/emailsend.dart';
import 'package:frontend/screens/authentication/forgotpassword/forgotpassword.dart';
import 'package:frontend/screens/authentication/myaccount.dart';
import 'package:frontend/screens/orders/orders.dart';
import 'package:frontend/screens/orders/orderplaced.dart';
import 'screens/authentication/signin/signin.dart';
import 'screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/home': (context) => const Home(),
        '/signin': (context) => const SignIn(),
        '/myaccount': (context) => const MyAccount(),
        '/orders': (context) => const Orders(),
        '/forgotpassword': (context) => const ForgotPassword(),
        '/emailsent': (context) => const EmailSent(),
        '/orderplaced': (context) => const OrderPlaced()
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SignIn(),
    );
  }
}
