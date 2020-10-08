import 'package:flutter/material.dart';
import 'package:pickamovie/pages/homepage.dart';
import 'package:pickamovie/pages/moviechart.dart';
import 'package:pickamovie/pages/title.dart';
import 'package:pickamovie/services/movie_db.dart';
import 'package:pickamovie/services/movie_tag_db.dart';
import 'package:pickamovie/services/preferences_db.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:pickamovie/states/suggestion_tags_window.dart';
import 'package:pickamovie/states/tag_suggestions.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<MovieTagDb>(
          create: (_) => MovieTagDb(),
        ),
        Provider<MovieDb>(
          create: (_) => MovieDb(),
        ),
        Provider<PreferencesDb>(
          create: (_) => PreferencesDb(),
        ),
        ChangeNotifierProvider<ChosenMovie>(
          create: (_) => ChosenMovie(),
        ),
      ],
      child: MyApp(),
    ),
  );
} //=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pick a Movie",
      home: TitlePage(),
    );
  }
}
