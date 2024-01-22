import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mav/firebase_options.dart';
import 'package:mav/splash_screen.dart';
// import 'package:mav/design_screen.dart';
// import 'package:mav/parameters_screen.dart';
// import 'package:mav/test_screen.dart';
// import 'package:mav/video_edit_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(
    title: 'Flutter Demo',
    home:  SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
