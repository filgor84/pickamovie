import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickamovie/widgets/tag_choice_menu.dart';

class TagsToChoseMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "What kind of movie would you like?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
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
