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

const kOrderTextFieldDecoration = InputDecoration(
  hintText: '      بحيث تكون من مكان واحد فقط   ( من السوبر ماركت مثلا )',
  hintStyle: TextStyle(
    fontSize: 12,
  ),
  counterStyle: TextStyle(fontSize: 0),
  labelText: 'اكتب طلباتك...',
  labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(
      color: Colors.blueGrey,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(
      color: Colors.cyan,
      width: 2.0,
    ),
  ),
);
