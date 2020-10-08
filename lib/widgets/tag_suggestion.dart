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
      leading: Icon(
        Icons.local_movies,
        size: 35,
      ),
      title: Text(myTag.tagName),
      subtitle: Text(myTag.suggMovie.title),
      dense: true,
      onTap: selectTag,
    );
  }
}
