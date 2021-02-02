import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/models/tag.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:pickamovie/states/tag_suggestions.dart';
import 'package:pickamovie/widgets/tag_suggestion.dart';
import 'package:provider/provider.dart';

class SuggestionMenuNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: Provider.of<TagSuggestions>(context)
                .currentWindow
                .map((Tag t) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: TagSuggestion(
                          myTag: t,
                          selectTag: () {
                            Provider.of<ChosenMovie>(context, listen: false)
                                .addTag(t);
                          } //value.addTag(t),
                          ),
                    ))
                .toList(),
          ),
        ),
        Row(
          children: <Widget>[
            TextButton(
              onPressed: () {
                print("Backward");
                Provider.of<TagSuggestions>(context, listen: false)
                    .windowBack();
              },
              child: Icon(
                Icons.arrow_left,
                color: Colors.yellow,
              ),
            ),
            TextButton(
              onPressed: () {
                print("Forward");
                Provider.of<TagSuggestions>(context, listen: false).windowFwd();
              },
              child: Icon(
                Icons.arrow_right,
                color: Colors.yellow,
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }
}
