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
      dense: true,
      visualDensity: VisualDensity(vertical: -3.2),
      tileColor: Color.fromRGBO(0, 0, 0, 0.4),
      leading: Icon(
        Icons.local_movies,
        color: Colors.yellow,
      ),
      title: Text(
        myTag.tagName.toUpperCase(),
      ),
      subtitle: Text(
        myTag.suggMovie.title,
      ),
      onTap: selectTag,
    );
  }
}
