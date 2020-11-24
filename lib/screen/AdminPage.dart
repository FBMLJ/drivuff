import 'package:flutter/material.dart';
import 'package:flutter_app/components/CustomButton.dart';
class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>{

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Página Administrador"),
      ),
      body:
        Center(
          child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(buttonText: "Novo Curso",onPress: (){Navigator.pushNamed(context, '/novo_curso');},),
            CustomButton(buttonText: "Cursos",onPress: (){Navigator.pushNamed(context, '/cursos');},),
            CustomButton(buttonText: "Seus Cursos",onPress: (){Navigator.pushNamed(context, '/seguidos');},)

          ]
        )
        )
    );
          
  }
}