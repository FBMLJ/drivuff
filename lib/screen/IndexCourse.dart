import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/CustomTextField.dart';
import 'package:flutter_app/components/ListItem.dart';
import 'package:flutter_app/screen/FolderPage.dart';
class IndexCourse extends StatefulWidget {
  @override
  _IndexCourseState createState() => _IndexCourseState();
}

class _IndexCourseState extends State<IndexCourse>{
  
  List<QueryDocumentSnapshot> items = [];
  List<QueryDocumentSnapshot> aux_items = [];

  @override
  void initState()  {
    FirebaseFirestore.instance.collection("curso").where('iscourse',isEqualTo: true).get().then((value) {
      aux_items = value.docs;
      setState((){
        items = value.docs;
      });
    });
    super.initState();
  }


  Future<dynamic> _request() async{
    QuerySnapshot info  =await FirebaseFirestore.instance.collection("curso").orderBy("nome").get();
    return info.docs;
  }
  TextEditingController _inputController = TextEditingController(text:"");
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
            CustomTextField(lable: "Pesquisa",controller: _inputController,onChange: (text){
              String search = text;
              if(search==""){
                setState(() {
                  items = aux_items;
                });
                return;
              }
              FirebaseFirestore.instance.collection("curso").where('iscourse',isEqualTo: true).where("nome", isGreaterThan: search).where('nome', isLessThan: search + 'z').get().then((value) {
                if (text != _inputController.text) return
                setState(() {
                  items = value.docs;
                });
              });
            },
            ),
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


