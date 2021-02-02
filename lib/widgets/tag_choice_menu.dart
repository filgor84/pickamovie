import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/pages/moviechart.dart';
import 'package:pickamovie/services/db.dart';
import 'package:pickamovie/services/tags_tree_db.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:pickamovie/states/tag_suggestions.dart';
import 'package:pickamovie/widgets/suggestion_menu_new.dart';
import 'package:provider/provider.dart';

class TagChoiceMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    //final suggestionTags = Provider.of<SuggestionTagsWindow>(context);
    final chosenTags = Provider.of<ChosenMovie>(context);
    final _db = Provider.of<TagsTree>(context);
    return FutureBuilder(
        future: _db.getRelevantTags(chosenTags.tags),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            //List<Tag> relTags = snapshot.data.sublist(0, 6);
            if (snapshot.data.isEmpty) {
              Provider.of<Db>(context, listen: false)
                  .queryMoviesFromTags(
                      chosenTags.tags.map((e) => e.tagId).toList())
                  .then((value) {
                print(value);
                chosenTags.removeAll();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieChartPage(movies: value)));
              });
            }
            return ChangeNotifierProvider<TagSuggestions>(
              create: (_) => TagSuggestions(tagsToChose: snapshot.data),
              child: SuggestionMenuNew(),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
