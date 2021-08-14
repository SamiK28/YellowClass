import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yellowclass/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return MaterialApp(
            title: "Yellow Class",
            theme: ThemeData(
              primaryColor: Color(0xFF7D050B),
              //primarySwatch: Color(0xFF7D050B),
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Color(0xFF111211),
            ),
            home: Home(),
          );
        });
  }
}
