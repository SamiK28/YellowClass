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
    return MaterialApp(
      title: "Yellow Class",
      theme: ThemeData(
          primaryColor: Color(0xFF7D050B), brightness: Brightness.dark),
      home: Home(),
    );
  }
}
