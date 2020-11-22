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

  @override
  void initState()  {
    FirebaseFirestore.instance.collection("curso").where('iscourse',isEqualTo: true).get().then((value) {
    
      setState((){
        items = value.docs;
      });
    });
    super.initState();
  }


  Future<dynamic> _request() async{
    QuerySnapshot info  =await FirebaseFirestore.instance.collection("curso").get();
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
            CustomTextField(lable: "Pesquisa",controller: _inputController,onChange: (){},),
           ListView.builder(
            itemCount: items.length,shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: ListItem(text: items[index].data()['nome'], onPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoulderPage(foulder: items[index],))
                  );}),
              );
            },
          )
            ],)
        )
    );
          
  }
}


