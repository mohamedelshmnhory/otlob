import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Splash – 1.png'), fit: BoxFit.cover)),
      height: size.height,
      width: size.width,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Group 119.png'),
                  fit: BoxFit.contain)),
          height: size.height * .4,
          width: size.width * .5,
        ),
      ),
    );
  }
}
