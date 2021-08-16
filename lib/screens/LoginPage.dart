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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctxt) => YellowClass()));
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: Image.asset(
                      "assets/images/google_logo.png",
                      //scale: 16,
                      fit: BoxFit.fitHeight,
                      height: 32,
                      color: Colors.grey[300],
                    ),
                    backgroundColor: Color(0xFF7D050B),
                    heroTag: 'Sign In',
                    label: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Sign In using Google',
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
