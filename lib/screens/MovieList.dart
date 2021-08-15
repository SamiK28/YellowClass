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
              // return Container(
              //     child: Center(
              //       child: Text("List is Empty"),
              //     ),
              //   );
              return SingleChildScrollView(
                child: Column(
                  children: data.values
                      .map(
                        (e) => MovieCard(movie: e),
                      )
                      .toList(),
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
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Container(
        height: size.height / 4.7,
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
                        image: FileImage(File(movie.posterPath!)),
                        fit: BoxFit.fill,
                      ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    movie.directorName,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white60),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
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
                                  Colors.transparent)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white70,
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
                                  Colors.transparent)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.delete_outline_outlined,
                                    color: Colors.red.withAlpha(200)),
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
                        // Container(
                        //   width: 90,
                        //   margin: const EdgeInsets.only(right: 8),
                        //   child: ElevatedButton.icon(
                        //     onPressed: () {},
                        //     label: Text("Edit"),
                        //     style: ButtonStyle(
                        //         foregroundColor: MaterialStateProperty.all(
                        //             Colors.white.withAlpha(250)),
                        //         textStyle: MaterialStateProperty.all(
                        //             TextStyle(fontSize: 12)),
                        //         backgroundColor: MaterialStateProperty.all(
                        //             Color(0xFF7D050B))),
                        //     icon: Icon(
                        //       Icons.edit_outlined,
                        //       size: 16,
                        //     ),
                        //   ),
                        // ),
                        // // SizedBox(
                        // //   width: 16,
                        // // ),
                        // OutlinedButton.icon(
                        //     icon: Icon(
                        //       Icons.delete_outline_outlined,
                        //       size: 16,
                        //     ),
                        //     style: ButtonStyle(
                        //       foregroundColor: MaterialStateProperty.all(
                        //           Colors.white.withAlpha(200)),
                        //       textStyle: MaterialStateProperty.all(
                        //           TextStyle(fontSize: 12)),
                        //       side: MaterialStateProperty.all(BorderSide(
                        //           color: Color(0xFF7D050B), width: 2)),
                        //     ),
                        //     onPressed: () {},
                        //     label: Text("Delete"))
                      ],
                    ),
                  )
                ],
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
