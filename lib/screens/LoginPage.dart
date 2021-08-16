import 'package:flutter/material.dart';

import 'package:yellowclass/DataModels/MovieModel.dart';
import 'package:yellowclass/screens/YellowClass.dart';
import 'package:yellowclass/services/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                backgroundColor: Colors.white60,
                radius: 50,
                child: Icon(
                  Icons.person_outline,
                  size: 50,
                  color: Colors.grey.shade900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: FloatingActionButton.extended(
                  onPressed: () async {
                    try {
                      final user = await Services().signInWithGoogle();
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
