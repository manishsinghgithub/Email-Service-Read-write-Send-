import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:send_email/AuthServices/authServices.dart';
import 'package:provider/provider.dart';

class SignInpage extends StatelessWidget {
  const SignInpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'image/1st.svg',
              height: 250,
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Holla, Dear!\nHow have you been?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sing in to use Gmail Srvices.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                final provider =
                    Provider.of<AuthServices>(context, listen: false);
                await provider.SignInWithGoogle();
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'image/google.png',
                    height: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Google Accounts',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "alert: This Application provides services from gmail that" +
                  " include you data from google account such that email, name and access token." +
                  " If you are agreed to share these information, continue to the signin process!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              'image/bottom.svg',
              height: 150,
            ),
            /*Image.asset(
              'image/bottom.png',
              height: 150,
            ),*/
          ],
        ),
      ),
    );
  }
}
