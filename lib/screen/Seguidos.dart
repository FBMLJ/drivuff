import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/CustomTextField.dart';
import 'package:flutter_app/components/ListItem.dart';
import 'package:flutter_app/screen/FolderPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Seguidos extends StatefulWidget {
  @override
  _SeguidosState createState() => _SeguidosState();
}

class _SeguidosState extends State<Seguidos>{
  
  List items = [];

  @override
  void initState()  {
    FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
      var curso = FirebaseFirestore.instance.collection("curso");
      value.data()["cursos"].forEach((elem){
        print(elem);
        curso.doc(elem).get().then((value)  {
          setState(() {
            items.add(value);
          });
        });
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cursos"),
      ),
      body:
        Center(
          child: Column(
            children: <Widget>[
            
           ListView.builder(
            itemCount: items.length,shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: ListItem(text: items[index].data()['nome'], onPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoulderPage(foulder: items[index],iscouse: true,))
                  );}),
              );
            },
          )
            ],)
        )
    );
          
  }
}


