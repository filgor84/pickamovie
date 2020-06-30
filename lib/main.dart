import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/movie.dart';
import 'models/tag.dart';
import 'recsys/tag_suggestion.dart';

class SuggestionTagsModel extends ChangeNotifier {
  final List<Tag> _tags = [];
  UnmodifiableListView<Tag> get tags => UnmodifiableListView(_tags);
  final List<List<Tag>> _suggestionsWindows = [];
  TagSuggestionsLoader _tagSuggestionsLoader = TagSuggestionsLoader();
  int cur = 0;
  UnmodifiableListView<Tag> get suggestions =>
      UnmodifiableListView(_suggestionsWindows[cur]);

  void addTag(Tag t) {
    if (tags.length < 3) {
      _tags.add(t);
      notifyListeners();
    } else {
      print("Warning: trying to search more than 3 tags");
    }
  }

  void updateSuggestionWindows() async {
    _suggestionsWindows.clear();
    _suggestionsWindows.add(await _loadNewSuggestions());
    cur = 0;
  }

  void removeAllTags() async {
    _tags.clear();
    updateSuggestionWindows();
    notifyListeners();
  }

  void removeTagAt(int i) {
    _tags.removeAt(i);
    updateSuggestionWindows();
    notifyListeners();
  }

  Future<List<Tag>> _loadNewSuggestions() async {
    await _tagSuggestionsLoader.updateAvailableTags(_tags);
    return _tagSuggestionsLoader.getNRandomTags(6);
  }

  windowFwd() async {
    if (cur == _suggestionsWindows.length - 1) {
      List<Tag> newSuggestions = await _loadNewSuggestions();
      if (newSuggestions.isNotEmpty) {
        _suggestionsWindows.add(newSuggestions);
        cur++;
      }
    } else {
      cur++;
    }
    notifyListeners();
  }

  windowBack() {
    if (cur > 0) {
      cur--;
    }
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SuggestionTagsModel(),
      child: MyApp(),
    ),
  );
} //=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pick a Movie",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[800],
        title: Text("Pick a Movie"),
      ),
      body: Column(
        children: <Widget>[
          YourMovie(),
          TagsToChose(),
        ],
      ),
    );
  }
}

class YourMovie extends StatefulWidget {
  @override
  _YourMovieState createState() => _YourMovieState();
}

class _YourMovieState extends State<YourMovie> {
  List<Tag> _chosenTags = [
    Tag(
      tagName: "Comedy",
      suggMovie: Movie(
        title: "Forrest Gump",
        imdbId: "1",
        popularity: 100,
      ),
    ),
    Tag(
      tagName: "Comedy",
      suggMovie: Movie(
        title: "Forrest Gump",
        imdbId: "1",
        popularity: 100,
      ),
    ),
    Tag(
      tagName: "Comedy",
      suggMovie: Movie(
        title: "Forrest Gump",
        imdbId: "1",
        popularity: 100,
      ),
    ),
  ];

  void addTag(Tag tag) {
    if (_chosenTags.length < 3) {
      _chosenTags.add(tag);
    } else {
      print("Error, suggestion max lenght exceeded");
    }
  }

  void removeTag(int i) {
    setState(() {
      _chosenTags.removeAt(i);
      print("Removed tags at $i");
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_chosenTags);
    final tagList = <Widget>[];
    for (var i = 0; i < _chosenTags.length; i++) {
      tagList.add(MyChosenTag(
        ctag: _chosenTags[i].tagName,
        cancel: () => removeTag(i),
      ));
    }
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
            child: Column(
              children: tagList,
            ),
          ),

          /*ChosenTag(
            ctag: "Undefined",
          ),*/
          ButtonTheme(
            minWidth: double.infinity,
            buttonColor: Colors.deepOrange,
            textTheme: ButtonTextTheme.primary,
            child: RaisedButton(
              onPressed: () => {},
              child: Text("Get movie suggestions"),
            ),
          ),
        ],
      ),
    );
  }
}

class MyChosenTag extends StatelessWidget {
  final String ctag;
  final Function cancel;
  MyChosenTag({this.ctag, this.cancel});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ctag),
      trailing: FlatButton(
        child: Icon(Icons.cancel),
        onPressed: () {
          print("Cancel");
          cancel();
        },
      ),
    );
  }
}

class TagsToChose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              "What kind of movie would you like?",
              style: Theme.of(context).textTheme.headline6,
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          TagChoiceMenu(),
          ChangeTagsButtons()
        ],
      ),
    );
  }
}

class ChangeTagsButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FlatButton(
          onPressed: () => {},
          child: Icon(Icons.arrow_left),
        ),
        FlatButton(
          onPressed: () => {},
          child: Icon(Icons.arrow_right),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class TagChoiceMenu extends StatefulWidget {
  @override
  _TagChoiceMenuState createState() => _TagChoiceMenuState();
}

class _TagChoiceMenuState extends State<TagChoiceMenu> {
  List<Tag> _suggestedTags = [
    Tag(
      tagName: "Comedy",
      suggMovie: Movie(
        title: "Forrest Gump",
        imdbId: "1",
        popularity: 100,
      ),
    ),
    Tag(
      tagName: "Comedy",
      suggMovie: Movie(
        title: "Forrest Gump",
        imdbId: "1",
        popularity: 100,
      ),
    ),
    Tag(
      tagName: "Comedy",
      suggMovie: Movie(
        title: "Forrest Gump",
        imdbId: "1",
        popularity: 100,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: _suggestedTags
            .map((Tag t) => TagSuggestion(
                  myTag: t,
                  selectTag: () => {},
                ))
            .toList(),
      ),
    );
  }
}

class TagSuggestion extends StatelessWidget {
  final Tag myTag;
  final Function selectTag;
  TagSuggestion({this.myTag, this.selectTag});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.local_movies,
        size: 35,
      ),
      title: Text(myTag.tagName),
      subtitle: Text(myTag.suggMovie.title),
      dense: true,
      onTap: selectTag,
    );
  }
}

class MyTagSuggestion extends StatelessWidget {
  final String tag;
  final String movieSuggested;
  MyTagSuggestion({this.tag, this.movieSuggested});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () => {},
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Text(
                tag,
              ),
              Text(movieSuggested)
            ],
          ),
        ));
  }
}
