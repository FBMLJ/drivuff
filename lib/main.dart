import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/screen/Cadastro.dart';
import 'package:flutter_app/screen/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/stores/app.store.dart';
import 'package:flutter_app/themes/app.theme.dart';
import 'package:flutter_app/screen/Home.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() async{
  //treicho de codigo para adicionar o acionar o firebase em todo projeto
  WidgetsFlutterBinding.ensureInitialized(); // fundamental essa linha
  await Firebase.initializeApp();
  //rodar o projeto
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<AppStore>.value(value: AppStore())],
      child: MaterialApp(
      title: 'DriveUFF',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',

      routes: {
        '/': (context) => LoginPage(),
        '/cadastro': (context) => CadastroPage(),
        '/home': (context) => Home(title: 'Histórico'),
      },

    ),
    );
  }
}

