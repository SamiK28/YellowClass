import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
part 'MovieModel.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String directorName;
  @HiveField(2)
  late String timestamp;
  @HiveField(3)
  late String? posterPath;
  MovieModel({
    required this.title,
    required this.directorName,
    required this.timestamp,
    required this.posterPath,
  });
}

class DB {
  static final DB _singleton = DB._internal();

  factory DB() {
    return _singleton;
  }

  DB._internal();
  late Box<MovieModel> box;

  Future<Box> initDB(
    String id,
  ) async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();

    Hive.init(directory.path);
    try {
      Hive.registerAdapter(MovieModelAdapter());
    } catch (e) {
      print(e);
    }
    box = await Hive.openBox<MovieModel>(id);

    return box;
  }

  void closeDB() async {
    await box.close();
  }

  Future<void> addMovie(MovieModel model) async {
    await box.put('${model.timestamp}-${model.title}', model);
  }

  Future<void> updateMovie(MovieModel model) async {
    await model.save();
  }

  Future<void> deleteMovie(MovieModel model) async {
   await model.delete();
  }
}
