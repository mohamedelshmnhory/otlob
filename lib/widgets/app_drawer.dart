import 'package:flutter/material.dart';
import 'package:otlob/providers/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xffFFC501)),
            child: Container(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () async {
                  Provider.of<Auth>(context, listen: false).logout();
                  // pageTurn(LoginScreen(), context);
                },
                child: Text(
                  'تسجيل الخروج',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
