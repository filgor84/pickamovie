import 'package:flutter/material.dart';
import 'package:pickamovie/pages/title.dart';
import 'package:pickamovie/services/db.dart';
import 'package:pickamovie/services/tags_tree_db.dart';
import 'package:pickamovie/states/chosen_movie.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<TagsTree>(
          create: (_) => TagsTree(),
        ),
        Provider<Db>(
          create: (_) => Db(),
        ),
        /*Provider<PreferencesDb>(
          create: (_) => PreferencesDb(),
        ),*/
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
