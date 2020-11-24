import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/CustomButton.dart';
import 'package:flutter_app/components/FigButton.dart';
import 'package:flutter_app/controlles/file.controller.dart';
import 'package:flutter_app/store/file.upload.dart';
import 'package:flutter_app/stores/app.store.dart';
import 'package:flutter_app/themes/app.theme.dart';
import 'package:flutter_app/widgets/File-list.widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  int _counter = 0;
  bool uploadlist = true;
  bool uploadfile = false;
  get key => null;

  @override
  void initState()  {
    User user = FirebaseAuth.instance.currentUser;
    if (user != null){
      
    FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
    firebaseStore.collection("user").doc(user.uid).get().then((collectionStream){

    if (collectionStream['admin']){
      Navigator.pushReplacementNamed(context, "/admin_page");
    }
    else {
      firebaseStore.collection("user").where("admin",isEqualTo: true).get().then((value) {
        print("--------------------------");
        if (value.docs.length==0){
          print("PAssei aqui");
          firebaseStore.collection("user").doc(user.uid).update({'admin': true}).then((value) => Navigator.pushReplacementNamed(context, "/admin_page"));
        }
        else{
          super.initState();
        }
      });
    }
    });
  
    }
    
  }
  whichlist(BuildContext context){

    if (uploadlist == true){
      return Filelistupload();
    } else if (uploadfile == true){
      return Fileupload();
    }
    else    {
      return Filelistdownload();
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);
    final controller = new FileController(store);
    if (store.currentState == "none"){
      controller.changeSelection("upload");
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: <Widget>[
              Text('Back', textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.green
              ),),
                  Observer (builder: (_) => FlatButton(onPressed: (){uploadlist=true; uploadfile=false; controller.changeSelection("upload"); setState(() {

                  });}, child: Text(' UPLOAD ', style: TextStyle(fontWeight: store.currentState == "upload" ? FontWeight.bold : FontWeight.normal , color: store.currentState == "upload" ? Colors.black : Colors.green ,), ), ),),
                  Observer (builder: (_) => FlatButton(onPressed: (){uploadlist=false; uploadfile=false; controller.changeSelection("download"); setState(() {

                  });}, child: Text('DOWNLOAD', style: TextStyle(fontWeight: store.currentState == "download" ? FontWeight.bold : FontWeight.normal, color: store.currentState == "download" ? Colors.black : Colors.green ,),),),),
                  ]),
            Text('Total de arquivos que você subiu:',
            ),

            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('0'),
                  Text('0'),
                  Text('0'),
                ]
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
              FigButton(text: 'Figuras', image: 'assets/images/figuras.png', callback: null, width: 142 ),
              FigButton(text: 'Vídeos',callback: null, image: 'assets/images/avimp3mpgflv.png', width: 142 ),
              FigButton(text: 'Docs',callback: null, image: 'assets/images/pdfdocpptxls.png', width: 142 ),
            ]
            ),
        Expanded(child: Observer(builder: (_) => Container(child: whichlist(context),),),),
        BottomAppBar(child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(icon: Icon(
            Icons.cloud_upload),
            onPressed: () {uploadlist=false; uploadfile=true;
                setState(() {

                });
                /*Navigator.push(context,
                MaterialPageRoute(builder: (context) => Fileupload()))*/;},
            ),
        IconButton(
            icon: Icon(
                Icons.cloud_download
            ),
            onPressed:null,
        ),
          ],
        ),
      ),
    ],
    ),
    );
  }
}

