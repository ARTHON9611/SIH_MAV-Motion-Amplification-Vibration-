import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mav/services/firebase_auth_methods.dart';


class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void _signup() async {
    await Firebase.initializeApp();
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
  }

  void _login() async {
    await Firebase.initializeApp();
    FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/Signup'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 12.0),
            TextButton(
              onPressed: _signup,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}