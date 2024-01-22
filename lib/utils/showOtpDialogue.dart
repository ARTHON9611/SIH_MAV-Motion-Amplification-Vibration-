import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showOtpDialogue({required BuildContext context,required TextEditingController otpController,required VoidCallback onPressed}){
  showDialog(context: context,barrierDismissible: false, builder: (context)=>AlertDialog(
    title: Text("Enter OTP"),
    content: TextField(
      controller: otpController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Enter OTP",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
    ),
    actions: [
      TextButton(onPressed:onPressed, child: Text("Submit"))
    ]));
}