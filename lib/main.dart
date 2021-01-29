import 'package:flutter/material.dart';
import 'package:otlob/providers/auth.dart';
import 'package:otlob/providers/retaurants.dart';
import 'package:otlob/screens/home.dart';
import 'package:otlob/screens/login_screen.dart';
import 'package:otlob/screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Restaurants(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Otlob',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Tajawal',
          ),
          home: auth.isAuth
              ? Home()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Splash()
                          : LoginScreen(),
                ),
        ),
      ),
    );
  }
}
