import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/pages/moviechart.dart';
import 'package:pickamovie/services/recsys.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:pickamovie/states/tag_suggestions.dart';
import 'package:pickamovie/widgets/suggestion_menu_new.dart';
import 'package:provider/provider.dart';

class TagChoiceMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    final chosenTags = Provider.of<ChosenMovie>(context);
    final _recsys = Provider.of<RecSys>(context);
    return FutureBuilder(
      future: _recsys.getRecommendedTags(chosenTags.tags),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.isEmpty) {
            _recsys.getRecommendedMovies(chosenTags.tags).then((value) {
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
      },
    );
  }
}
