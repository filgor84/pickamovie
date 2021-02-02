import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/models/tag.dart';

class TagSuggestion extends StatelessWidget {
  final Tag myTag;
  final Function selectTag;
  TagSuggestion({this.myTag, this.selectTag});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color.fromRGBO(0, 0, 0, 0.4),
      leading: Icon(
        Icons.local_movies,
        color: Colors.yellow,
        size: 35,
      ),
      title: Text(
        myTag.tagName.toUpperCase(),
        style: TextStyle(fontSize: 15),
      ),
      subtitle: Text(
        myTag.suggMovie.title,
        style: TextStyle(fontSize: 14),
      ),
      dense: true,
      onTap: selectTag,
    );
  }
}
