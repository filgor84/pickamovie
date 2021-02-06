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
      debugShowCheckedModeBanner: false,
      title: "Pick a Movie",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepOrange,
        accentColor: Colors.orange,
        buttonTheme: ButtonThemeData(buttonColor: Colors.yellowAccent),
        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 20.0, fontFamily: 'Hind'),
          bodyText1: TextStyle(fontSize: 15.0, fontFamily: 'Hind'),
        ),
      ),
      home: TitlePage(),
    );
  }
}
