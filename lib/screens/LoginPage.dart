import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yellowclass/DataModels/MovieModel.dart';
import 'package:yellowclass/screens/YellowClass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final user = authResult.user;

      return user!;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Color(0xFF7D050B),
                radius: 50,
                child: Icon(
                  Icons.person_outline,
                  size: 50,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FloatingActionButton.extended(
                  onPressed: () async {
                    try {
                      final user = await signInWithGoogle();
                      await DB().initDB(user.uid);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctxt) => YellowClass()));
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(
                    Icons.login,
                    color: Colors.white.withAlpha(200),
                  ),
                  backgroundColor: Color(0xFF7D050B),
                  heroTag: 'Sign In',
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign In using Google',
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
