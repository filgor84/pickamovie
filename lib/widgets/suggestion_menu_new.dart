import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/models/tag.dart';
import 'package:pickamovie/services/recsys.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:pickamovie/states/tag_suggestions.dart';
import 'package:pickamovie/widgets/tag_suggestion.dart';
import 'package:provider/provider.dart';

class SuggestionMenuNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _tagSuggestions = Provider.of<TagSuggestions>(context);
    return Column(
      children: [
        Container(
          height: 313,
          child: ListView(
            children: _tagSuggestions.currentWindow
                .map((Tag t) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.5),
                      child: TagSuggestion(
                        myTag: t,
                        selectTag: () {
                          List<Tag> views = _tagSuggestions.windows
                              .reduce((value, element) => value + element)
                              .toList();
                          Provider.of<RecSys>(context, listen: false)
                              .updateMetrics(t, views)
                              .then((_) {
                            Provider.of<ChosenMovie>(context, listen: false)
                                .addTag(t);
                          });
                        },
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
