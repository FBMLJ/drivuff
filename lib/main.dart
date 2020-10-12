import 'package:flutter/material.dart';
import 'package:flutter_app/screen/Cadastro.dart';
import 'package:flutter_app/screen/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/themes/app.theme.dart';
import 'package:flutter_app/screen/Home.dart';


void main() async{
  //treicho de codigo para adicionar o acionar o firebase em todo projeto
  WidgetsFlutterBinding.ensureInitialized(); // fundamental essa linha
  await Firebase.initializeApp();
  //rodar o projeto
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriveUFF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',

      routes: {
        '/': (context) => LoginPage(),
        '/cadastro': (context) => CadastroPage(),
        '/home': (context) => Home(title: 'Aqui é o programa'),
      },

    );
  }
}

