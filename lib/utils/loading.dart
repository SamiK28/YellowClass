import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(
        color: Colors.red.shade700,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text('Loading....'),
      )
    ],
  ));
  }
}
