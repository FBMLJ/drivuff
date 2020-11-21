import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/screen/Cadastro.dart';
import 'package:flutter_app/screen/Login.dart';
import 'package:flutter_app/screen/AdminPage.dart';

import 'package:flutter_app/screen/Home.dart';
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //rodar o projeto
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization =  Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
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
            '/admin_page': (context) => AdminPage()
            
            }
          )
        );
      });
  }
}

