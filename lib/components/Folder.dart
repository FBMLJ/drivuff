import 'package:flutter/material.dart';

class Folder extends StatelessWidget {
  final folderId;
  Folder ({Key key, this.folderId});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          color: Colors.white,

          onPressed: (){},
          child: Column(
            children: <Widget>[
              Image.asset('imagens/folder.png',height: 80,),
              Text("Nome")
            ],

          )
      )

          );
  }
}
