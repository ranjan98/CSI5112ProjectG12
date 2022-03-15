import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 3.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 3.0),
  ),
);

const emailDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(width: 2),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  suffixIcon: Icon(Icons.email),
  hintText: 'Enter your email',
  labelText: 'Email',
);
