import 'package:flutter/material.dart';
import 'package:otlob/providers/retaurants.dart';
import 'package:otlob/screens/home.dart';
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
      ],
      child: MaterialApp(
        title: 'Otlob',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Tajawal',
        ),
        home: Home(),
      ),
    );
  }
}
