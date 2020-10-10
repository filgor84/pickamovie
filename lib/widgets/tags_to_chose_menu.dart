import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/widgets/tag_choice_menu.dart';

class TagsToChoseMenu extends StatelessWidget {
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
            padding: EdgeInsets.symmetric(vertical: 6),
          ),
          TagChoiceMenu(),
        ],
      ),
    );
  }
}
