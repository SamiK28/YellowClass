import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yellowclass/DataModels/MovieModel.dart';

class AddMovie extends StatefulWidget {
  final MovieModel? movie;
  AddMovie({this.movie});

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  late TextEditingController _titleCtr;
  late TextEditingController _dnameCtr;
  late String? _posterPath;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late bool isEdit;
  String buttonText = "Submit";
  @override
  void initState() {
    if (widget.movie == null) {
      _titleCtr = TextEditingController();
      _dnameCtr = TextEditingController();
      _posterPath = null;
      isEdit = false;
    } else {
      _titleCtr = TextEditingController(text: widget.movie!.title);
      _dnameCtr = TextEditingController(text: widget.movie!.directorName);
      _posterPath = widget.movie!.posterPath;
      isEdit = true;
      buttonText = "Update";
    }
    super.initState();
  }

  _getFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _posterPath = image.path;
      });
    }
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      if (isEdit) {
        widget.movie!.title = _titleCtr.text;
        widget.movie!.directorName = _dnameCtr.text;
        widget.movie!.posterPath = _posterPath;
        await DB().updateMovie(widget.movie!);
      } else {
        final String dt = DateTime.now().millisecondsSinceEpoch.toString();
        MovieModel mm = MovieModel(
            title: _titleCtr.text,
            directorName: _dnameCtr.text,
            posterPath: _posterPath,
            timestamp: dt);

        await DB().addMovie(mm);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a Movie"),
        ),
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: FloatingActionButton.extended(
              onPressed: submit,
              backgroundColor: Color(0xFF7D050B).withAlpha(230),
              label: Text(
                buttonText,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      _posterPath == null || _posterPath!.isEmpty
                          ? Container()
                          : Stack(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: Image.file(
                                      File(
                                        _posterPath!,
                                      ),
                                      height: 360,
                                    )),
                                CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _posterPath = null;
                                        });
                                      },
                                      icon: Icon(Icons.close)),
                                ),
                              ],
                            ),
                      FloatingActionButton.extended(
                        elevation: 10,
                        heroTag: 'Add Poster',
                        onPressed: _getFromGallery,
                        foregroundColor: Colors.white70,
                        label: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _posterPath == null
                              ? Text("Poster")
                              : Text("Choose Another"),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 0, right: 8, top: 5),
                          child: Icon(Icons.add_a_photo_rounded),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _titleCtr,
                  textCapitalization: TextCapitalization.words,
                  autofocus: true,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Cannot be Empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    alignLabelWithHint: true,
                    filled: true,
                    focusColor: Colors.amber,
                    hintText: "Title of the Movie",
                    labelText: "Title",
                    fillColor: Colors.grey.shade900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _dnameCtr,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Cannot be Empty";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    alignLabelWithHint: true,
                    filled: true,
                    focusColor: Colors.amber,
                    hintText: "Name of the Director",
                    labelText: "Director Name",
                    fillColor: Colors.grey.shade900,
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
