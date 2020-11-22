import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/components/ListItem.dart';
class FoulderPage extends StatefulWidget {
  final foulder;

  const FoulderPage({Key key, this.foulder}) : super(key: key);
  @override
  _FoulderPageState createState() => _FoulderPageState(this.foulder);
}

class _FoulderPageState extends State<FoulderPage> {
  final foulder;
  List<QueryDocumentSnapshot> items=[];
  _FoulderPageState(this.foulder);
  

  @override
  void initState(){
    if (this.foulder.data()["iscourse"] == true){
      FirebaseFirestore.instance.collection("curso").where('dono',isEqualTo: foulder.id).get().then((value) {
    
        setState((){
          items = value.docs;
        });
      });
    }
    // else {
      
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${foulder.data()['nome']}"),
      ),
      body:
        Center(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: ListItem(text: items[index].data()['nome'], onPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoulderPage(foulder: items[index],))
                  );}),
              );
            },
          )
        )
    );
  }
}