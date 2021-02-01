import 'package:flutter/material.dart';

class MyChosenTag extends StatelessWidget {
  final String ctag;
  final Function cancel;
  MyChosenTag({this.ctag, this.cancel});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ListTile(
        tileColor: Color.fromRGBO(0, 0, 0, 0.4),
        dense: true,
        title: Text(ctag),
        trailing: TextButton(
          child: Icon(
            Icons.cancel,
            color: Colors.yellow,
          ),
          onPressed: () {
            print("Cancel");
            cancel();
          },
        ),
      ),
    );
  }
}
