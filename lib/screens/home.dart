import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yellowclass/screens/LoginPage.dart';
import 'package:yellowclass/screens/YellowClass.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static Widget loading = Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(
        color: Colors.red.shade700,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text('Loading....'),
      )
    ],
  ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        initialData: null,
        builder: (context, data) {
          if (!data.hasData || data.data == null) {
            return loading;
          } else {
            if (data.data == false) {
              return LoginPage();
            } else {
              return YellowClass();
            }
          }
        },
        future: googleSignIn.isSignedIn(),
      ),
    );
  }
}
