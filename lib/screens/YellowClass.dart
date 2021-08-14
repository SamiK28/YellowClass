import 'package:flutter/material.dart';
import 'package:yellowclass/screens/AddMovie.dart';
import 'package:yellowclass/screens/MovieList.dart';
import 'package:yellowclass/screens/Profile.dart';

class YellowClass extends StatefulWidget {
  @override
  _YellowClassState createState() => _YellowClassState();
}

class _YellowClassState extends State<YellowClass> {
  List<Widget> screens = [MoviesList(), Profile()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            Navigator.push(context, MaterialPageRoute(builder: (ctxt)=>AddMovie()));
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
