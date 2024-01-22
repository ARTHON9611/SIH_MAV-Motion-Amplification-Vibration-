import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mav/googleSignIn.dart';
import 'package:mav/home_screen.dart';
import 'package:mav/utils/showOtpDialogue.dart';
import 'package:mav/utils/snackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(
          context, "Email verification link sent to your email address");
    } on FirebaseAuthException catch (e) {
      print(e.code);
      showSnackBar(context, e.message!);
    }
  }

  Future<void> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser!.emailVerified) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        showSnackBar(context,
            "Please verify your email address first and then login.Verification Link sent to your email address");
        await _auth.currentUser!.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      showSnackBar(context, e.message!);
    }
  }

  Future<void> logout({required BuildContext context}) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GoogleSignInScreen()));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      showSnackBar(context, e.message!);
    }
  }

  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, "Password reset link sent to your email address");
    } on FirebaseAuthException catch (e) {
      print(e.code);
      showSnackBar(context, e.message!);
    }
  }

  Future<void> phoneAuth(
      {required String phoneNumber,
      required BuildContext context,
      required TextEditingController otpController}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.code);
          showSnackBar(context, e.message!);
        },
        codeSent: (String verificationId, int? resendToken) async {
          showOtpDialogue(
              context: context,
              otpController: otpController,
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);
                await _auth.signInWithCredential(credential);
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      showSnackBar(context, e.message!);
    }
  }

  Future<void> googleSignIn(BuildContext context) async {
    try{
    final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    if (googleAuth.accessToken != null) {
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

        print(userCredential.user!.photoURL);
        if (userCredential.additionalUserInfo!.isNewUser) {
          print("New User");
        }
      }
    }
  }on FirebaseAuthException catch (e) {
      print(e.code);
      showSnackBar(context, e.message!);
    }
}}
