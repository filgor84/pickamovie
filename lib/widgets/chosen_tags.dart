import 'package:flutter/material.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:provider/provider.dart';

import 'chosen_tag.dart';

class ChosenTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myMovie = Provider.of<ChosenMovie>(context);
    return Column(children: [
      for (var i = 0; i < myMovie.tags.length; i++)
        MyChosenTag(
            ctag: myMovie.tags[i].tagName, cancel: () => myMovie.removeAt(i))
    ]);
  }
}
