import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final onPress;
  final text;
  ListItem({Key key,this.onPress, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(onPressed: this.onPress,child: Text(this.text),),
    );
  }
}