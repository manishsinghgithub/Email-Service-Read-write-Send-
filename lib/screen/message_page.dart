import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_email/AuthServices/authServices.dart';
import 'package:send_email/screen/composeMail.dart';

class MesssagePage extends StatelessWidget {
  const MesssagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Home, Buddy!'),
        backgroundColor: Colors.grey.shade800,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              final provider =
                  Provider.of<AuthServices>(context, listen: false);

              await provider.SignOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL!),
                      radius: 38,
                    ),
                  ),
                  Text(
                    user.displayName! + "\n(" + user.email! + ")",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Instruction:-\nOnce you tap to compose, please fill fileds correctly.' +
                      'Other you may have unsuccessfull delivery of mail. ' +
                      '\nThis applicatin using you credentials on the beahlf of you agreement.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'image/1.png',
                height: 320,
              ),
              MaterialButton(
                color: Colors.grey.shade500,
                height: 45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(18),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ComposeMailPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Compose',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.add_circle,
                      size: 30,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
