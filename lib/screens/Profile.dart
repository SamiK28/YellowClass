import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            primary: true,
            title: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Profile",
                style: TextStyle(fontFamily: 'SpaceAge', fontSize: 36),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.grid_on_outlined)),
              )
            ],
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            expandedHeight: 100,
            floating: true,
          ),
        ],
      ),
    );
  }
}
