// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signin_signup_10/services/onboard.dart';
import '../screens/signup_page.dart';
import '../services/auth_service.dart';

class MyLogInColumn extends StatefulWidget {
  @override
  State<MyLogInColumn> createState() => _MyLogInColumnState();
}

class _MyLogInColumnState extends State<MyLogInColumn> {

  final GlobalKey<FormState> _myKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final GlobalKey<FormState> _passwordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _myKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (email) {
                      if (!EmailValidator.validate(email!)) {
                        return 'Geçersiz bir e-mail adresi girildi.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email_outlined,
                            color: Colors.grey, size: 30),
                        hintText: 'Lutfen e-mail adresinizi giriniz',
                        hintStyle: TextStyle(
                          color: Color(0xff281537),
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                        labelText: 'E-mail',
                        labelStyle: TextStyle(
                          color: Color(0xffB81736),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (password) {
                      if (password!.length < 5) {
                        return 'Lütfen 6 ve üzeri uzunlukta bir şifre giriniz';
                      } else {
                        return null; // girilen password kritere uygun ise hiçbir şey yazdırma, devam et
                      }
                    },
                    obscureText: true, //gizlensin
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.lock_clock_outlined,
                            color: Colors.grey, size: 30),
                        hintText: 'Lutfen sifrenizi giriniz',
                        hintStyle: TextStyle(
                          color: Color(0xff281537),
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xffB81736),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 30),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Container(
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
                ),
                onPressed: () async {
                  if (_myKey.currentState!.validate()) {
                    // düzgün bir email- password girilmişse, her şey true ise;
                    final user = await Provider.of<Auth>(context, listen: false)
                        .signInEmailAndPassword(
                            _emailController.text, _passwordController.text);
                    // şuan firebase'de giriş yaptı
                      // e mailini doğrulamamış ise alert dialog ile uyar
                    await _controlEmailAlertDialog();
                    if(!user!.emailVerified){
                      // firebase üzerinden giriş yaptı olarak gözüktüğü için tekrar dışarı at
                      await Provider.of<Auth>(context, listen: false).signOut();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnBoardWidget(),
                      ),
                    );
                  }
                },
                child: Text(
                  'SIGN IN',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
          SizedBox(height: 70),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Don\'t have an account ?',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _controlEmailAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hatırlatma'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('E-mail Kontrol Hatırlatması'),
                Text(
                    'Lütfen devam etmeden önce e-mail kutunuzu kontrol ediniz ve mailinizi doğrulamamışsanız doğrulayınız. Aksi halde sayfadan çıkış yapacaksınız.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
