import 'package:flutter/material.dart';
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
        '/signin': (context) => const SignIn()
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SignIn(),
    );
  }
}
