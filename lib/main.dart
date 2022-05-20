import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_email/AuthServices/authServices.dart';
import 'package:send_email/screen/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCUZxLHdEoCI9tuU_b7zBAsPb_b3GjYzwg",
        appId: "1:170393812211:android:635cf2d236f314e3d14b86",
        messagingSenderId: "170393812211",
        projectId: "email-sending-1cfc9"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthServices(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
