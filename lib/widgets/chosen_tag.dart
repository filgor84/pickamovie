import 'package:flutter/material.dart';

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
