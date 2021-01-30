import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/widgets/tag_choice_menu.dart';

class TagsToChoseMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "What kind of movie would you like?",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              TagChoiceMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
