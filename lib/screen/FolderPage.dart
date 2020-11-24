

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_app/components/ListItem.dart';
class FoulderPage extends StatefulWidget {
  final foulder;
  final iscouse;

  const FoulderPage({Key key, this.foulder, this.iscouse}) : super(key: key);
  @override
  _FoulderPageState createState() => _FoulderPageState(this.foulder, this.iscouse);
}

class _FoulderPageState extends State<FoulderPage> {
  final foulder;
  Map user;
  final bool iscouse;
  List<QueryDocumentSnapshot> items=[];
  _FoulderPageState(this.foulder, this.iscouse);
  bool ehSeguido = false;  

  @override
  void initState(){
    if (this.foulder.data()["iscourse"] == true){
      FirebaseFirestore.instance.collection("curso").where('dono',isEqualTo: foulder.id).get().then((value) {
    
        setState((){
          items = value.docs;
        });
      });
      FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
        setState(() {
          this.user =value.data();
        });
        if (this.user["cursos"].contains(foulder.id)) setState(() {this.ehSeguido=true;});
      }
      
      );
    }
    // else {
      
    // }
    super.initState();
  }

  _star_icon(){
    if ( this.iscouse){
        if(!this.ehSeguido){

            return Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  this.user["cursos"].add(foulder.id);
                  FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser.uid)
                  .update({"cursos": this.user["cursos"]}).then((value){
                    setState(() {
                      ehSeguido = true;
                    });
                  });
                },
                child: Icon(
                  Icons.star_border,
                  size: 40.0,
                ),
              )
            );
          }
        else{

            return Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  this.user["cursos"].remove(foulder.id);
                  FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser.uid)
                  .update({"cursos": this.user["cursos"]}).then((value){
                    setState(() {
                      ehSeguido = false;
                    });
                  });
                },
                child: Icon(
                  Icons.star,
                  size: 40.0,
                ),
              )
            );
          }
        }
          else{
            
            return  Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.file_upload,
                  size: 40.0,
                ),
              )
            );
            }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${foulder.data()['nome']}"),
        actions: <Widget>[
          _star_icon()
                  ]
      ),
      body:
        Center(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: ListItem(text: items[index].data()['nome'], onPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoulderPage(foulder: items[index],iscouse: false,))
                  );}),
              );
            },
          )
        )
    );
  }
}