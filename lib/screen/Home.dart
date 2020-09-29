import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/CustomButton.dart';
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
    return Container(
      color: Colors.white,
      child: Column(
        children:<Widget>[
          Text("Home"),
          CustomButton(buttonText: "Deslogar",onPress: (){
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.signOut();

            Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
          })
        ],
      )
    );
  }
}
