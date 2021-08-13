import 'package:flutter/material.dart';

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
                  onPressed: () {},
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