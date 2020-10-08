import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/services/movie_tag_db.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:pickamovie/states/tag_suggestions.dart';
import 'package:pickamovie/widgets/suggestion_menu.dart';
import 'package:provider/provider.dart';

class TagChoiceMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    //final suggestionTags = Provider.of<SuggestionTagsWindow>(context);
    final chosenTags = Provider.of<ChosenMovie>(context);
    final _db = Provider.of<MovieTagDb>(context);
    return FutureBuilder(
        future: _db.getRelevantTags(chosenTags.tags),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            //List<Tag> relTags = snapshot.data.sublist(0, 6);
            return ChangeNotifierProvider<TagSuggestions>(
              create: (_) => TagSuggestions(tagsToChose: snapshot.data),
              child: SuggestionMenu(),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
