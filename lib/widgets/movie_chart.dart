import 'package:flutter/material.dart';
import 'package:pickamovie/models/movie.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieChart extends StatelessWidget {
  final List<Movie> movies;
  MovieChart({this.movies});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < movies.length; i++)
          MovieTile(
            movie: movies[i],
            position: i + 1,
          )
      ],
    );
  }
}

class MovieTile extends StatelessWidget {
  final Movie movie;
  final int position;
  MovieTile({this.position, this.movie});
  @override
  Widget build(BuildContext context) {
    print(movie.stars);
    return ListTile(
      leading: Chip(
        label: Text(
          position.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.orange[300],
      ),
      title: Text(
        movie.title,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: PopularityStars(movie.stars),
      onTap: () {
        print("Go to movie $movie");
        String code = movie.imdbId.toString();
        code = "0" * (7 - code.length) + code;
        String url = "https://www.imdb.com/title/tt$code/";
        if (canLaunch(url) != null)
          launch(url);
        else
          // can't launch url, there is some error
          throw "Could not launch $url";
      },
    );
  }
}

class PopularityStars extends StatelessWidget {
  final int _yellow;
  final int _grey;
  PopularityStars(int stars)
      : _yellow = stars,
        _grey = 5 - stars;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
            for (var i = 0; i < _yellow; i++)
              Icon(
                Icons.star,
                color: Colors.yellow[600],
              )
          ] +
          [
            for (var i = 0; i < _grey; i++)
              Icon(
                Icons.star,
                color: Colors.grey,
              ),
          ],
    );
  }
}
