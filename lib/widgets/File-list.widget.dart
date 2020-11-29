import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controlles/file.controller.dart';
import 'package:flutter_app/stores/app.store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Filelistupload extends StatefulWidget {
  @override
  _FilelistuploadState createState() => _FilelistuploadState();
}

class _FilelistuploadState extends State<Filelistupload> {
  final _dateFormat = new DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);
    final controller = new FileController(store);

    if (store.currentState == "none") {
      controller.changeSelection("upload");
    }

    return Observer (name: 'test', builder: (_) => ListView.builder(
      padding: EdgeInsets.only(left: 40),
      itemCount: store.files.length,
      itemBuilder: (context, index) {
        var item = store.files[index];
        return ListTile(
              title: Text(item.title, style: TextStyle(fontSize: 18, color: item.done ? Colors.black.withOpacity(0.2) : Colors.black,),),
              subtitle: Text((item.url),),);
      }
      ),
    );
  }
}

class Filelistdownload extends StatefulWidget {
  @override
  _FilelistdownloadState createState() => _FilelistdownloadState();
}

class _FilelistdownloadState extends State<Filelistdownload> {
  var listpressed = new List(2);

  @override
  Widget build(BuildContext context) {
    listpressed[0] = false;
    listpressed[1] = false;

    return ListView(padding: EdgeInsets.only(left: 40),
      children: [
        ListTile(title: Text('teste11111.jpg', style: TextStyle(fontSize: 18, color: listpressed[0]==false ? Colors.black : Colors.red),),
          subtitle: Text('/Teste'),
          dense: false,
          onLongPress: (){
            setState(() {});listpressed[0]=true;},),
        ListTile(title: Text('doc122222.pdf', style: TextStyle(fontSize: 18, color: Colors.black),),
            subtitle: Text('/Teste'),dense: false),],);
  }
}
