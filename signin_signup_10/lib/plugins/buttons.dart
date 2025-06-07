// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:signin_signup_10/screens/signup_page.dart';
import 'package:signin_signup_10/screens/types_of_login_page.dart';

class MyButtons extends StatelessWidget {
  String text;
  MyButtons({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffB81736),
            Color(0xff281537),
          ],
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(color: Colors.white),
        ),
        onPressed: () {
          text == "SIGN IN"
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TypesLoginPage(),
                  ),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
        },
        child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
      ),
    );
  }
}
