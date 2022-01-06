import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:send_email/AuthServices/authServices.dart';
import 'package:send_email/screen/message_page.dart';
import 'package:send_email/screen/signIn.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Somthing went Wrong!',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            );
          } else if (snapshot.hasData) {
            return MesssagePage();
          } else {
            return const SignInpage();
          }
        });
  }
}
