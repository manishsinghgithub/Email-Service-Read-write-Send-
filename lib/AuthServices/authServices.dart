import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices extends ChangeNotifier {
  static final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['https://mail.google.com/']);

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future SignInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }
      _user = googleUser;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future SignOut() async {
    await _googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  static Future<GoogleSignInAccount?> googletoken() async {
    if (await _googleSignIn.isSignedIn()) {
      return _googleSignIn.currentUser;
    } else {
      await _googleSignIn.signIn();
      return _googleSignIn.currentUser;
    }
  }
}
