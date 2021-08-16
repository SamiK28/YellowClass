import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yellowclass/DataModels/MovieModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellowclass/screens/AddMovie.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: ValueListenableBuilder<Box>(
            valueListenable: DB().box.listenable(),
            builder: (context, data, child) {
              if (data.values.length == 0) {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/box.png",
                            scale: 8,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("It seems a bit empty here"),
                              Text("Tap on the '+' button to add some movies")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: data.values
                        .map(
                          (e) => MovieCard(movie: e),
                        )
                        .toList(),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Container(
        height: size.height / 4.2,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: size.width / 3.5,
              child: movie.posterPath == null || movie.posterPath!.isEmpty
                  ? Icon(
                      Icons.hide_image_outlined,
                      color: Colors.white38,
                      size: 48,
                    )
                  : null,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: movie.posterPath == null || movie.posterPath!.isEmpty
                    ? null
                    : DecorationImage(
                        image: FileImage(
                          File(
                            movie.posterPath!,
                          ),
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Director",
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          color: Colors.red.shade600),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      movie.directorName,
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white60),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(9)),
                                foregroundColor: MaterialStateProperty.all(
                                    Colors.white.withAlpha(250)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 12)),
                                overlayColor: MaterialStateProperty.all(
                                    Colors.white.withAlpha(100)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF111211))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctxt) => AddMovie(
                                            movie: movie,
                                          )));
                            },
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(9)),
                                foregroundColor: MaterialStateProperty.all(
                                    Colors.white.withAlpha(250)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 12)),
                                overlayColor: MaterialStateProperty.all(
                                    Colors.white.withAlpha(100)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF111211))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.red.withAlpha(200),
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.red.withAlpha(200),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _confirmation(context),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _confirmation(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete this Movie?'),
      backgroundColor: Colors.grey.shade900,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("This cannot be undone"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.grey.shade900,
              ),
              foregroundColor: MaterialStateProperty.all(Colors.white)),
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () async {
            await DB().deleteMovie(movie);
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.grey.shade900,
              ),
              foregroundColor: MaterialStateProperty.all(Colors.red)),
          child: const Text(
            'Yes',
          ),
        ),
      ],
    );
  }
}
