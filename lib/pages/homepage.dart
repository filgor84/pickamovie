import 'package:flutter/material.dart';

import 'package:pickamovie/widgets/movie.dart';
import 'package:pickamovie/widgets/tags_to_chose_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/icons/icon.png",
            height: 4,
          ),
        ),
        backgroundColor: Color.fromRGBO(15 * 16 + 15, 31, 0, 0.8),
        title: Text("Pick a Movie",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Stack(children: [
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/img/sipario.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            TagsToChoseMenu(),
            Movie(),
          ],
        ),
      ]),
    );
  }
}
