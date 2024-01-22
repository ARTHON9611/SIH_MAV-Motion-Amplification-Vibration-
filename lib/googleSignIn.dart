import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mav/home_screen.dart';
import 'package:mav/services/firebase_auth_methods.dart';

class GoogleSignInScreen extends StatefulWidget {
  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
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
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(auth.currentUser!=null){
      bioAuth();      
    }
  }
  void _googleSignIn() async {
    // Add Google Sign-In logic here
    FirebaseAuthMethods(FirebaseAuth.instance).googleSignIn(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _googleSignIn,
          child: Container(
  width:300,
  height:80,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        // decoration: BoxDecoration(color: Colors.blue),
          child:
          Image.network(
              'http://pngimg.com/uploads/google/google_PNG19635.png',
              fit:BoxFit.cover
          )                  
      ),
      SizedBox(
        width: 5.0,
      ),
      Text('Sign-in with Google')
    ],
  ),
),
        ),
      ),
    );
  }
}