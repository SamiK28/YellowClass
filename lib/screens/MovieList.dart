import 'package:flutter/material.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
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
                "Movies",
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
