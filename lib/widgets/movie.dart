import 'package:flutter/material.dart';
import 'package:pickamovie/pages/moviechart.dart';
import 'package:pickamovie/services/db.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:provider/provider.dart';

import 'chosen_tags.dart';

class Movie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieDb = Provider.of<Db>(context, listen: false);
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
                  movieDb
                      .queryMoviesFromTags(
                          myMovie.tags.map((e) => e.tagId).toList())
                      .then((value) {
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
