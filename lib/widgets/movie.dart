import 'package:flutter/material.dart';
import 'package:pickamovie/pages/moviechart.dart';
import 'package:pickamovie/services/movie_db.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:provider/provider.dart';

import 'chosen_tags.dart';

class Movie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieDb = Provider.of<MovieDb>(context, listen: false);
    final myMovie = Provider.of<ChosenMovie>(context);
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Text(
              "Your movie",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            height: 170,
            child: ChosenTags(),
          ),
          ButtonTheme(
            minWidth: double.infinity,
            buttonColor: Colors.deepOrange,
            textTheme: ButtonTextTheme.primary,
            child: RaisedButton(
              onPressed: () => {
                movieDb
                    .queryMoviesFromTags(
                        myMovie.tags.map((e) => e.tagId).toList(), 10)
                    .then((value) {
                  print(value);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieChartPage(movies: value)));
                })
              },
              child: Text("Get movie suggestions"),
            ),
          ),
        ],
      ),
    );
  }
}
