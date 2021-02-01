import 'package:flutter/material.dart';
import 'package:pickamovie/models/movie.dart';
import 'package:pickamovie/widgets/movie_chart.dart';

class MovieChartPage extends StatelessWidget {
  MovieChartPage({this.movies});
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(15 * 16 + 15, 31, 0, 0.8),
          title: Text("Suggested Movies"),
        ),
        body: MovieChart(movies: movies));
  }
}
