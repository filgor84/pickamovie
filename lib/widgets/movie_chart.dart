import 'package:flutter/material.dart';
import 'package:pickamovie/models/movie.dart';

class MovieChart extends StatelessWidget {
  final List<Movie> movies;
  MovieChart({this.movies});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < 10; i++)
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
      subtitle: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow[600],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[600],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[600],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[600],
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 30,
      ),
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
