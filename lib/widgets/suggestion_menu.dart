import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/models/tag.dart';
import 'package:pickamovie/services/movie_tag_db.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:pickamovie/states/tag_suggestions.dart';
import 'package:pickamovie/widgets/tag_suggestion.dart';
import 'package:provider/provider.dart';

class SuggestionMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3,
            children: Provider.of<TagSuggestions>(context)
                .currentWindow
                .map((Tag t) => TagSuggestion(
                    myTag: t,
                    selectTag: () {
                      Provider.of<ChosenMovie>(context, listen: false)
                          .addTag(t);
                    } //value.addTag(t),
                    ))
                .toList(),
          ),
        ),
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                print("Backward");
                Provider.of<TagSuggestions>(context, listen: false)
                    .windowBack();
              },
              child: Icon(Icons.arrow_left),
            ),
            FlatButton(
              onPressed: () {
                print("Forward");
                Provider.of<TagSuggestions>(context, listen: false).windowFwd();
              },
              child: Icon(Icons.arrow_right),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }
}
