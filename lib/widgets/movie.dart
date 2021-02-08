import 'package:flutter/material.dart';
import 'package:pickamovie/pages/moviechart.dart';
import 'package:pickamovie/services/recsys.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:provider/provider.dart';

import 'chosen_tags.dart';

class Movie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _recsys = Provider.of<RecSys>(context, listen: false);
    final myMovie = Provider.of<ChosenMovie>(context);
    return Visibility(
      visible: myMovie.tags.isNotEmpty,
      child: Card(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 3,
              ),
              child: Text(
                "Your movie",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100,
              child: ChosenTags(),
            ),
            ButtonTheme(
              minWidth: double.infinity,
              buttonColor: Colors.deepOrange,
              textTheme: ButtonTextTheme.primary,
              child: TextButton(
                onPressed: () => {
                  _recsys.getRecommendedMovies(myMovie.tags).then((value) {
                    print(value);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieChartPage(movies: value)));
                  })
                },
                child: Text(
                  "Get movie suggestions",
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
