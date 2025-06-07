// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:signin_signup_10/screens/patient_login_page.dart';
import 'package:signin_signup_10/screens/types_of_login_page.dart';
import '../services/auth_service.dart';

class MySignUpColumn extends StatefulWidget {
  const MySignUpColumn({super.key});

  @override
  State<MySignUpColumn> createState() => _MySignUpColumnState();
}

class _MySignUpColumnState extends State<MySignUpColumn> {
  final GlobalKey<FormState> _myKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Form(
            key: _myKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'E-mail adresi gerekli';
                      }
                      if (!EmailValidator.validate(email)) {
                        return 'Geçersiz bir e-mail adresi girildi.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email_outlined,
                          color: Colors.grey, size: 30),
                      hintText: 'Lütfen geçerli bir e-mail adresi giriniz',
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
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Şifre gerekli';
                      }
                      if (password.length <= 5) {
                        return 'Lütfen 6 ve üzeri uzunlukta bir şifre giriniz';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.lock_clock_outlined,
                          color: Colors.grey, size: 30),
                      hintText: 'Lütfen şifrenizi giriniz',
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
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _confirmController,
                    validator: (confirmData) {
                      if (confirmData == null || confirmData.isEmpty) {
                        return 'Şifre onayı gerekli';
                      }
                      if (confirmData != _passwordController.text) {
                        return 'Girdiğiniz şifreler birbiriyle uyuşmuyor';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: Color(0xffB81736),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      hintText: 'Şifreyi tekrar giriniz',
                      hintStyle: TextStyle(
                        color: Color(0xff281537),
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                      suffixIcon: Icon(
                        Icons.lock_person_outlined,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 300,
          height: 60,
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
              elevation: 0,
            ),
            onPressed: _isLoading
                ? null
                : () async {
                    if (_myKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        // Auth sınıfını direkt kullan (Provider yerine)
                        final auth = Auth();
                        final user = await auth.createEmailAndPassword(
                          _emailController.text.trim(),
                          _passwordController.text,
                        );

                        if (user != null && !user.emailVerified) {
                          await user.sendEmailVerification();
                          await _controlFirstEmailAlertDialog();
                        }

                        // Login sayfasına yönlendir
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => PatientLoginPage(),
                          ),
                        );
                      } catch (e) {
                        // Hata mesajı göster
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Kayıt başarısız: ${e.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    }
                  },
            child: _isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
          ),
        ),
        SizedBox(height: 40),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Do you have already an account?',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TypesLoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign In',
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
    );
  }

  Future<void> _controlFirstEmailAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Email Doğrulaması',
            style: TextStyle(
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'E-mail Doğrulayınız',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Lütfen devam etmeden önce e-mail kutunuzu kontrol ediniz ve mailinizi doğrulayınız. Aksi halde giriş sayfasında otomatik çıkış yapacaksınız.',
                  style: TextStyle(
                    color: Color(0xFF718096),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF4A90E2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
}
