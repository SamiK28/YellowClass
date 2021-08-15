import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yellowclass/DataModels/MovieModel.dart';
import 'package:yellowclass/screens/AddMovie.dart';
import 'package:yellowclass/screens/MovieList.dart';
import 'package:yellowclass/screens/Profile.dart';

class YellowClassBuilder extends StatelessWidget {
  final String id = FirebaseAuth.instance.currentUser!.uid;
  YellowClassBuilder();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DB().initDB(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          return Container();
        } else {
          return YellowClass();
        }
      },
    );
  }
}

class YellowClass extends StatefulWidget {
  @override
  _YellowClassState createState() => _YellowClassState();
}

class _YellowClassState extends State<YellowClass> {
  List<Widget> screens = [MoviesList(), Profile()];
  List<String> headers = ['Movies', 'Profile'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              headers[currentIndex],
              style: TextStyle(fontFamily: 'SpaceAge', fontSize: 36),
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 20),
          //     child: IconButton(
          //         onPressed: () {}, icon: Icon(Icons.grid_on_outlined)),
          //   )
          // ],
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          currentIndex: currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          fixedColor: Colors.white,
          onTap: (i) {
            setState(() {
              currentIndex = i;
            });
          },
          unselectedItemColor: Colors.white24,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_outlined),
                label: 'List',
                activeIcon: Icon(Icons.movie_rounded)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Profile',
                activeIcon: Icon(Icons.person))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctxt) => AddMovie()));
          },
          backgroundColor: Color(0xFF7D050B),
          foregroundColor: Colors.white.withAlpha(200),
          tooltip: 'Add a Movie',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
