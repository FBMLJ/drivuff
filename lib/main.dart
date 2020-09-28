import 'package:flutter/material.dart';
import 'package:flutter_app/screen/Cadastro.dart';
import 'package:flutter_app/screen/Login.dart';
import 'package:firebase_core/firebase_core.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //rodar o projeto
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
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
      });
  }
}
