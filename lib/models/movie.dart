import 'package:flutter/foundation.dart';

class Movie {
  String title;
  String imdbId;
  int popularity;
  int stars;

  Movie({
    @required title,
    @required imdbId,
    @required popularity,
    @required stars,
  }) {
    this.title = title;
    this.imdbId = imdbId;
    this.popularity = popularity;
    this.stars = stars;
  }

  Movie.fromJson(Map json)
      : title = json["title"],
        imdbId = json["imdbid"],
        popularity = int.parse(json["popularity"]);

  Movie.fromSql(Map sqlmap)
      : title = sqlmap["title"],
        imdbId = sqlmap["imdbId"].toString(),
        popularity = sqlmap["rating"] ?? 0,
        stars = sqlmap["stars"] ?? 0;

  @override
  String toString() {
    return "Title:$title\nImdbId:$imdbId\nPopularity:$popularity\nStars: $stars\n";
  }
}
