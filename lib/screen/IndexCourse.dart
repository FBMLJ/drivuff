import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/CustomButton.dart';
class IndexCourse extends StatefulWidget {
  @override
  _IndexCourseState createState() => _IndexCourseState();
}

class _IndexCourseState extends State<IndexCourse>{
  List<String> course = ["Oi","Gente"];
  final items = List<String>.generate(10000, (i) => "Item $i");

  
  Future<dynamic> _request() async{
    QuerySnapshot info  =await FirebaseFirestore.instance.collection("curso").get();
    return info.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Cursos"),
      ),
      body:
        Center(
          child: ListView.builder(
            itemCount: course.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${course[index]}'),
              );
            },
          )
        )
    );
          
  }
}


