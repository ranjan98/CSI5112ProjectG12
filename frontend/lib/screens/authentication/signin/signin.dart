import 'package:flutter/material.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../services/signin_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers(); //mocking up the login for now
  }

  bool showPassword = true;
  IconData visibility = Icons.visibility;
  bool loading = false;
  String email = "";
  String password = "";
  String error = "";

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      // create an app bar for displaying the the name of the application
      // on successful sign in, it will also have a drawer and cart button (action button)
      appBar: AppBar(
        title: const Text('UOMart',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 60),
            Row(
              children: const <Widget>[
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            const SizedBox(height: 30),
            if (error.isEmpty == false)
              Center(
                  child: Text(
                error,
                style: const TextStyle(color: Colors.red),
              )),
            if (error.isEmpty == false) const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 320.0,
                child: TextFormField(
                  key: const Key("emailAdd"),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value.toLowerCase();
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      suffixIcon: Icon(Icons.email),
                      hintText: 'Enter your email',
                      labelText: 'Email'),
                  // Validate the input
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter the E-mail Address';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email)) {
                      return 'Please Enter a Valid Email Address';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 320.0,
                child: TextFormField(
                  key: const Key("password"),
                  obscureText: showPassword,
                  onChanged: (value) {
                    password = value.toString();
                  },
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
                      labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 320,
                child: TextButton(
                  key: const Key("signin"),
                  onPressed: () {
                    //forgot password screen
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/forgotpassword');
                  },
                  child: const Text(
                    'Forgot Password?',
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FloatingActionButton.extended(
                  label: const Text('Sign In'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      // var result = await fetchUser(email);
                      var result = await fetchUsers();
                      // ignore: unnecessary_null_comparison
                      if (result == null) {
                        setState(() {
                          error = 'Could not Sign In';
                          loading = false;
                        });
                      } else {
                        // ignore: avoid_print
                        var user = result
                            .firstWhere((element) => element.email == email);
                        print("It is working: UID during sign in is : " +
                            user.uid);
                        if (user.password == password) {
                          userProvider.loginUser(user);
                          if (user.role == "merchant") {
                            Navigator.of(context).pushNamed('/merchant-home');
                          } else {
                            Navigator.of(context).pushNamed('/home');
                          }
                        } else {
                          setState(() {
                            error = 'Could not Sign In';
                            loading = false;
                          });
                        }
                      }
                    }
                  },
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
                    'Register now',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    //signup screen using material page route // replacing this as this is not preferred
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SignUp()));

                    // using named route
                    Navigator.of(context).pushNamed('/signup');
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ]),
        ),
      ),
    );
  }
}
