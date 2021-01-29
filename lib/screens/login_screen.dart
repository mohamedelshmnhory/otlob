import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otlob/providers/auth.dart';
import 'package:otlob/widgets/constants.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 65,
                ),
                Center(
                  child: Image.asset(
                    'assets/Group 119.png',
                    height: 234,
                    width: 148,
                  ),
                ),
                SizedBox(height: 42),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                color: Color(0xff46200B), fontSize: 25),
                          ),
                        ],
                      ),
                      SizedBox(height: 42),
                      TextFormField(
                        decoration: loginTextFieldDecoration,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty || value.length < 10) {
                            return 'Invalid email!';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _authData['email'] = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: passTextFieldDecoration,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            return "Password is too short!";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0xffAEC632),
                  child: Text(
                    'دخول',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  onPressed: _submit,
                  padding: EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 10,
                    bottom: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
