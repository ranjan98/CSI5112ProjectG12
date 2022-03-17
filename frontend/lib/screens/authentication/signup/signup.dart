import 'package:flutter/material.dart';
import '../../../services/signup_service.dart';

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
  bool loading = false;
  String email = "";
  String name = "";
  String password = "";
  String rePassword = "";
  String error = "";
  String role = "customer";
  List<String> roles = ['Customer', 'Merchant'];

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                const SizedBox(height: 30),
                Row(
                  children: const <Widget>[
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      name = value.toString();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      suffixIcon: Icon(Icons.person),
                      hintText: 'Enter your Name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your Name';
                      } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                          .hasMatch(name)) {
                        return 'Please! Enter your Name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 320,
                  child: TextFormField(
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
                      labelText: 'Email',
                    ),
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
                // no need of mobile number of user
                // const SizedBox(height: 6),
                // SizedBox(
                //   width: 320,
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(width: 2),
                //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
                //       ),
                //       suffixIcon: Icon(Icons.mobile_screen_share),
                //       hintText: 'Enter your mobile number',
                //       labelText: 'Mobile',
                //     ),
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Please enter mobile number';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 320,
                  child: TextFormField(
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
                const SizedBox(height: 6),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    obscureText: showRePassword,
                    onChanged: (value) {
                      rePassword = value.toString();
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                        labelText: 'Re-enter password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please re-enter password';
                      }
                      if (value != password) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 320,
                  child: DropdownButtonFormField(
                    items: roles.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      role = value.toString().toLowerCase();
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        suffixIcon: Icon(Icons.person_outline),
                        hintText: 'Choose Account Type'),
                  ),
                ),
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
                        Navigator.of(context)
                            .pushNamed('/terms-and-conditions');
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Row(
                  children: <Widget>[
                    FloatingActionButton.extended(
                      label: const Text('Sign Up'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (isChecked) {
                            Navigator.of(context).popAndPushNamed('/home');
                            setState(() => loading = true);
                            var result =
                                await createUser(name, email, password, role);
                            // ignore: unnecessary_null_comparison
                            if (result == null) {
                              setState(() {
                                error = 'Could not Sign In';
                                loading = false;
                              });
                            } else {
                              // ignore: avoid_print
                              print("It is working: UID during sign in is : " +
                                  result.uid);
                              if (role == roles[1].toLowerCase()) {
                                Navigator.of(context)
                                    .popAndPushNamed('/merchant-home');
                              } else {
                                Navigator.of(context).popAndPushNamed('/home');
                              }
                            }
                          } else {
                            setState(() {
                              error =
                                  "Please agree to the Terms and Conditions";
                            });
                          }
                        }
                      },
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
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
