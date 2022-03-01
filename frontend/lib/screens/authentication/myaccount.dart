import 'package:flutter/material.dart';
import 'package:frontend/screens/authentication/info_card.dart';

const url = "https://ranjalgoyal.me";
const email = "ranjangoyal@uottawa.ca";
const phone = "613276xxxx";
const location = "Ottawa, Canada";

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Account'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.purple,
                child: Text(
                  'SD',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                "Harish",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              InfoCard(
                  text: "phone", icon: Icons.phone, onPressed: () async {}),
              InfoCard(text: "url", icon: Icons.web, onPressed: () async {}),
              InfoCard(
                  text: "location",
                  icon: Icons.location_city,
                  onPressed: () async {}),
              InfoCard(
                  text: "email", icon: Icons.email, onPressed: () async {}),
            ],
          ),
        ));
  }
}
