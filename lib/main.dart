import 'package:flutter/material.dart';
import 'package:flutter_app/screen/Cadastro.dart';
import 'package:flutter_app/screen/Login.dart';
import 'package:firebase_core/firebase_core.dart';


void main() {
  //treicho de codigo para adicionar o acionar o firebase em todo projeto
  Firebase.initializeApp();
  //rodar o projeto
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //parte do codigo relacionada ao roteamento do aplicativo
      initialRoute: '/',

      routes: {
        '/': (context) => LoginPage(),
        '/cadastro': (context) => CadastroPage()
      },

    );
  }
}
