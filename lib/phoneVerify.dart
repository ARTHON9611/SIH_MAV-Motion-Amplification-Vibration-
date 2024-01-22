import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mav/services/firebase_auth_methods.dart';



class PhoneAuthScreen extends StatefulWidget {
  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  void _phoneAuth() async {
    await Firebase.initializeApp();
    FirebaseAuthMethods(FirebaseAuth.instance).phoneAuth(
      phoneNumber: _phoneController.text,
      context: context,
      otpController: _otpController,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter Phone Number'),
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Logic to send verification code
                _phoneAuth();
              },
              child: Text('Send Verification Code'),
            ),
          ],
        ),
      ),
    );
  }
}

class EnterOTP extends StatelessWidget {
  final String verificationId;

  EnterOTP(this.verificationId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
              // controller: _smsCodeController, if using controllers
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Logic to verify OTP
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
