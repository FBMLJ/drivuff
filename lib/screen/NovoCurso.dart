import 'package:flutter/material.dart';
import 'package:flutter_app/components/CustomButton.dart';
import 'package:flutter_app/components/CustomTextField.dart';
import 'package:flutter_app/model/Course.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
class NovoCurso extends StatefulWidget {
  @override
  _NovoCurso createState() => _NovoCurso();
}

class _NovoCurso extends State<NovoCurso>{
  TextEditingController _nameController = TextEditingController(text: "");
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Novo Curso"),
      ),
      body:
        Center(
          child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          CustomTextField(lable: "Nome", controller: _nameController,),
          CustomButton(buttonText: "Enviar",onPress: () async{
            String name = _nameController.text;
            Course curso = Course(name);
            FirebaseFirestore instace = FirebaseFirestore.instance;
            print(curso.toMap());
            instace.collection("curso").doc().set(curso.toMap());
            instace.collection("curso").where("nome", isEqualTo: name).get().then((value)  {
              String cursoId = value.docs[value.docs.length -1].id;
              instace.collection("curso").doc().set(curso.toMap1(cursoId));
              instace.collection("curso").doc().set(curso.toMap2(cursoId));
              instace.collection("curso").doc().set(curso.toMap3(cursoId));
            
              
            });
          },)
          ]
        )
        )
    );
          
  }
}