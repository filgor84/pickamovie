import 'package:flutter/material.dart';
import 'package:pickamovie/pages/homepage.dart';

class TitlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              child: Text(
                "Pick A Movie",
                style: TextStyle(fontSize: 50),
              ),
            ),
            TextButton(
              child: Text("Start"),
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
            )
          ],
        ),
      ),
    );
  }
}
