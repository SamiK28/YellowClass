import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yellowclass/screens/LoginPage.dart';

import 'package:yellowclass/services/services.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? photoUrl;
  String? name;
  @override
  void initState() {
    photoUrl = FirebaseAuth.instance.currentUser!.photoURL;
    name = FirebaseAuth.instance.currentUser!.displayName;
    name = name == null ? "" : name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
        width: size.width,
        height: size.height / 3,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: 50,
                  child: photoUrl == null || photoUrl!.isEmpty
                      ? Icon(
                          Icons.person,
                          size: 36,
                          color: Colors.white54,
                        )
                      : ClipOval(
                          child: Image.network(
                            photoUrl!,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red.shade900,
                  width: 3.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name!,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade900),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sign Out"),
            onTap: () async {
              try {
                await Services().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (ctxt) => LoginPage()),
                    (route) => false);
              } catch (e) {
                print(e);
              }
            },
          ),
        ),
      ),
    ])));
  }
}
