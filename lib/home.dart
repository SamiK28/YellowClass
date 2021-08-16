
import 'package:flutter/material.dart';


import 'package:yellowclass/screens/LoginPage.dart';
import 'package:yellowclass/screens/YellowClass.dart';
import 'package:yellowclass/services/services.dart';
import 'package:yellowclass/utils/loading.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        initialData: null,
        builder: (context, data) {
          if (!data.hasData || data.data == null) {
            return Loading();
          } else {
            if (data.data == false) {
              return LoginPage();
            } else {
             if(Services().auth.currentUser==null){
               return LoginPage();
             }
              return YellowClassBuilder();
            }
          }
        },
        future: Services().googleSignIn.isSignedIn(),
      ),
    );
  }
}
