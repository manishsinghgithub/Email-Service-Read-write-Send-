import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';
import 'package:send_email/AuthServices/authServices.dart';

class ComposeMailPage extends StatefulWidget {
  const ComposeMailPage({Key? key}) : super(key: key);

  @override
  State<ComposeMailPage> createState() => _ComposeMailPageState();
}

class _ComposeMailPageState extends State<ComposeMailPage> {
  final _formKey = GlobalKey<FormState>();
  String? to_email, subject, text_Message;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
        elevation: 0,
        backgroundColor: Colors.grey.shade800,
      ),
      backgroundColor: Colors.grey.shade800,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Image.asset(
              'image/bottom.png',
              height: 250,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "To Email",
                    ),
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return "Required Email.";
                      }
                      if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value.toString())) {
                        return 'Please enter a valid email Address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      to_email = value;
                    },
                  ),
                  TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Subject",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return "Required Field.";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      subject = value;
                    },
                  ),
                  TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Message",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return "Required Field.";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      text_Message = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  print('error');
                  return;
                }
                _formKey.currentState!.save();

                try {
                  await sendMail(
                      toMail: to_email.toString(),
                      Sub: subject.toString(),
                      text_msg: text_Message.toString());
                  Navigator.pop(context);
                } catch (e) {
                  print(e.toString());
                }
              },
              color: Colors.pink.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Send',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/*toMail: to_email.toString(),
                        sub: subject.toString(),
                        text: text_Message.toString(), */
  Future sendMail(
      {required String toMail,
      required String Sub,
      required String text_msg}) async {
    final user = await AuthServices.googletoken();
    if (user == null) {
      return;
    }
    final email = user.email;

    final auth = await user.authentication;
    final accessToken = auth.accessToken!;
    final smtpServer = gmailSaslXoauth2(email.toString(), accessToken);
    final message = Message()
      ..from = Address(email, user.displayName)
      ..recipients = [toMail]
      ..subject = Sub
      ..text = text_msg;

    try {
      await send(message, smtpServer);
      showSneckBar("Message Sent Successfully", context, true);
    } on MailerException catch (e) {
      print(e.toString());
      showSneckBar('Unsuccessful!', context, false);
    }
  }

  void showSneckBar(String text, BuildContext context, bool tol) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      backgroundColor: tol ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
