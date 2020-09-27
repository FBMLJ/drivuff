import 'package:flutter/material.dart';
import '../components/CustomButton.dart';
import '../components/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/User.dart';


//codigo responsavel pelo exibição da tela de cadastro
class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  //atributos
  TextEditingController _controllerEmail = TextEditingController(text: "");
  TextEditingController _controllerPassword = TextEditingController(text: "");
  TextEditingController _controllerName = TextEditingController(text: "");

  //metodos
  _onSeding(){
    String email = this._controllerEmail.text;
    String password = this._controllerPassword.text;
    String name = this._controllerName.text;


    UserModel user = UserModel( name,email, password);
    print(user.validateDateRegister());
    if (!user.validateDateRegister()){
      print(user.errorsMessage);
      return;
    }
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(email: email, password: password)
        //será executado se conseguir criar um usuario
        .then((firebaseUser) {
          FirebaseFirestore db = FirebaseFirestore.instance;
          db.collection("user").document( firebaseUser.user.uid ).setData(user.toMap());
    })
        //será executado quando falhar em criar um usuario
        .catchError((e)=>print("falha"));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

          width: MediaQuery.of(context).size.width ,
          height: MediaQuery.of(context).size.height  ,
          decoration: BoxDecoration(
            //gradiente
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.greenAccent]
              )
          ),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  //esse codigo cria um retangulo no meio da tela
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.5),

                      ),
                      width: MediaQuery.of(context).size.width *.7 ,
                      height: MediaQuery.of(context).size.height *.5  ,

                      child: Column(
                          children: <Widget>[
                            Text("Cadastro", style: TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            )),

                            CustomTextField(lable: 'Nome', keyboard: TextInputType.name,controller: this._controllerName,),
                            CustomTextField(lable: 'Email', keyboard: TextInputType.emailAddress,controller: this._controllerEmail),
                            CustomTextField(lable: 'Senha',password: true, controller: this._controllerPassword,),
                            CustomButton(buttonText: "Enviar", onPress: ()=>{this._onSeding()},),
                            CustomButton(buttonText: "Volta", onPress: ()=>{Navigator.pop(context)
                            }),
                          ]
                      )
                  )
              )
          )

      ),
    );;
  }
}
