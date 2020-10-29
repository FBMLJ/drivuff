import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/CustomMenuButton.dart';
import '../components/Folder.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("user").where("user.admin", isEqualTo: true).get().then((value) {
      if (value.docs.length == 0) db.collection("user").doc(auth.currentUser.uid).update({"admin": true});
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seus Cursos"),),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
            ),
            CustomMenuButton(buttonText: "Deslogar",image: 'imagens/logout.svg',textColor: Colors.red,onPress: (){
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut();

              Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
            }),
          ],
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,

          color: Colors.white,
          child: SingleChildScrollView(
              child: Wrap(
                
                children:<Widget>[

                  Folder()
                ],

              )
          )

      )

    );
  }
}
