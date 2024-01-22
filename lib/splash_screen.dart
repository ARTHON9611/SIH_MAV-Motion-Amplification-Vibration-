import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:mav/googleSignIn.dart';
import 'package:mav/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocalAuthentication Bio = LocalAuthentication();
  FirebaseAuth auth = FirebaseAuth.instance;
  void bioAuth() async{
    bool canCheckBiometrics = await Bio.canCheckBiometrics;
    if(canCheckBiometrics){
      bool authenticated = await Bio.authenticate(
        localizedReason: "Use Biometrics to login",
        options: AuthenticationOptions(
          stickyAuth: true,
          sensitiveTransaction: true)
        
      );
      if(authenticated){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }else{
        bioAuth();
      }
    }
  }
  @override
  void initState() {
    super.initState();
    // Simulate a delay for the splash screen
    if(auth.currentUser!=null){
      bioAuth();      
    }else{
      Timer(Duration(seconds: 3), () {
      // After the delay, navigate to the HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => GoogleSignInScreen(),
        ),
      );
    
    });
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // You can design your splash screen UI here
      backgroundColor: Colors.black,
      body: Center(
        child: Lottie.asset('assets/splashAnimation2.json',fit: BoxFit.cover),
      ),
    );
  }
}
