// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signin_signup_10/screens/welcome_page.dart';
import 'package:signin_signup_10/services/auth_service.dart';
import '../screens/home_page.dart';

class OnBoardWidget extends StatefulWidget {
  const OnBoardWidget({super.key});

  @override
  State<OnBoardWidget> createState() => _OnBoardWidgetState();
}

class _OnBoardWidgetState extends State<OnBoardWidget> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

    return StreamBuilder(
        stream: _auth.authState(), // bunu dinle
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.data != null
                ? const HomePage()
                : const WelcomeScreen();
          } else {
            return const SizedBox(
              height: 300,
              width: 300,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
