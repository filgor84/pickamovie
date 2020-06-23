import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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

class YourMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              children: <Widget>[
                MyChosenTag(
                  ctag: "Comedy",
                ),
                MyChosenTag(
                  ctag: "Sci-fi",
                ),
                MyChosenTag(
                  ctag: "Oscar",
                )
              ],
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
  MyChosenTag({this.ctag});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ctag),
      trailing: FlatButton(
        child: Icon(Icons.cancel),
        onPressed: () => {},
      ),
    );
  }
}

class ChosenTag extends StatelessWidget {
  final String ctag;
  ChosenTag({this.ctag});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(ctag),
              padding: EdgeInsets.symmetric(horizontal: 4.0),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: FlatButton(
                onPressed: () => {},
                child: Text("Cancel"),
              ),
            )
          ],
        ),
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


class TagChoiceMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.local_movies,
              size: 35,
            ),
            title: Text("Comedy"),
            subtitle: Text("Dr Strangelove"),
            dense: true,
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(
              Icons.local_movies,
              size: 35,
            ),
            title: Text("Comedy"),
            subtitle: Text("Dr Strangelove"),
            dense: true,
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(
              Icons.local_movies,
              size: 35,
            ),
            title: Text("Comedy"),
            subtitle: Text("Dr Strangelove"),
            dense: true,
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(
              Icons.local_movies,
              size: 35,
            ),
            title: Text("Comedy"),
            subtitle: Text("Dr Strangelove"),
            dense: true,
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(
              Icons.local_movies,
              size: 35,
            ),
            title: Text("Visually appealing"),
            subtitle: Text("Matrix, The (1999)"),
            dense: true,
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(
              Icons.local_movies,
              size: 35,
            ),
            title: Text("Comedy"),
            subtitle: Text("Dr Strangelove"),
            dense: true,
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}

class TagSuggestion extends StatelessWidget {
  final String tag;
  final String movieSuggested;
  TagSuggestion({this.tag, this.movieSuggested});
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
