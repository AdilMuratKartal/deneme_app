// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _myFirebaseInstance = FirebaseAuth.instance;

  Future<UserCredential> signInAnonymously() async {
    return await _myFirebaseInstance
        .signInAnonymously(); // userCredential tipi döndürür
  }

  Future<User?> createEmailAndPassword(String email, String password) async {
    UserCredential _userCredential = await _myFirebaseInstance
        .createUserWithEmailAndPassword(email: email, password: password);
    return _userCredential.user;
  }

  Future<void> signOut() async {
    await _myFirebaseInstance.signOut();
  }

  Stream<User?> authState() {
    // StreamBuilder ile dinlenir ve akış yapılır
    return _myFirebaseInstance
        .authStateChanges(); // kullanıcının şuanki sign in- out durumu döndürülür
  }

  Future<User?> signInEmailAndPassword(String email, String password) async {
    UserCredential _user = await _myFirebaseInstance.signInWithEmailAndPassword(
        email: email, password: password);
    return _user.user;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _myFirebaseInstance.signInWithCredential(credential);
  }
}
