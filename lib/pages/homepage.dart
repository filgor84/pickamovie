import 'package:flutter/material.dart';
import 'package:pickamovie/widgets/movie.dart';
import 'package:pickamovie/widgets/tags_to_chose_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[800],
        title: Text("Pick a Movie"),
      ),
      body: Column(
        children: <Widget>[
          Movie(),
          TagsToChoseMenu(),
        ],
      ),
    );
  }
}
