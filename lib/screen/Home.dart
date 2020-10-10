import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/CustomButton.dart';
import '../components/Folder.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seus Cursos"),),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            CustomButton(buttonText: "Deslogar",onPress: (){
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut();

              Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
            }),
          ],
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,

          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
              child: Wrap(

                children:<Widget>[


                ],

              )
          )

      )

    );
  }
}
