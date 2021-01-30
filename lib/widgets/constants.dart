import 'package:flutter/material.dart';

const loginTextFieldDecoration = InputDecoration(
  hintText: 'رقم الهاتف',
  hintStyle: TextStyle(color: Color(0xff46200B), fontSize: 20),
  filled: true,
  fillColor: Color.fromRGBO(174, 198, 50, 0.25),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  // border: InputBorder.none,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.black12, width: 0.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

const passTextFieldDecoration = InputDecoration(
  hintText: 'كلمة المرور',
  hintStyle: TextStyle(color: Color(0xff46200B), fontSize: 20),
  filled: true,
  fillColor: Color.fromRGBO(174, 198, 50, 0.25),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  // border: InputBorder.none,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.black12, width: 0.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

