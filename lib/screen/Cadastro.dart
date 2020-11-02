import 'package:flutter/material.dart';
import '../components/CustomButton.dart';
import '../components/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/User.dart';

import '../components/Usuario.dart';

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
  String _mensagemErro = "";
  String _mensagemSucesso = "";

  //metodos
  _onSeding(){
    String email = this._controllerEmail.text;
    String password = this._controllerPassword.text;
    String name = this._controllerName.text;
    
    //alerta
    void _showAlert (BuildContext context) {
      showDialog(context: context,
      builder: (context)=>AlertDialog(
        title: Text("Problemas ao enviar")
      ));
    };


    UserModel user = UserModel( name,email, password);
    print(user.validateDateRegister());
    if (!user.validateDateRegister()){
      _showAlert(context);
      return;
    }
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(email: email, password: password)
        //será executado se conseguir criar um usuario
        .then((firebaseUser) {
          FirebaseFirestore db = FirebaseFirestore.instance;
          db.collection("user").doc( firebaseUser.user.uid ).set(user.toMap());
          Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    })
        //será executado quando falhar em criar um usuario
        .catchError((e)=>print(e));

  }



  _validarCampos(){

    //Recupera dados dos campos
    String nome = _controllerName.text;
    String email = _controllerEmail.text;
    String senha = _controllerPassword.text;

    if( nome.isNotEmpty ){

      if( email.isNotEmpty && email.contains("@") ){

        if( senha.isNotEmpty && senha.length > 6 ){

          setState(() {
            _mensagemErro = "";
          });

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;

          _cadastrarUsuario( usuario );


        }else{
          setState(() {
            _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
          });
        }

      }else{
        setState(() {
          _mensagemErro = "Preencha o E-mail utilizando @";
        });
      }

    }else{
      setState(() {
        _mensagemErro = "Preencha o Nome";
      });
    }

  }

  _cadastrarUsuario( Usuario usuario ){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      /*
      //Salvar dados do usuário
      Firestore db = Firestore.instance;

      db.collection("user")
          .document( firebaseUser.user.uid )//.additionalUserInfo.providerId
          .setData( usuario.toMap() );

       */

      setState(() {
        _mensagemSucesso = "Usuário cadastrado";
      });

      Navigator.pushNamedAndRemoveUntil(
          context, "/home", (_)=>false
      );


    }).catchError((error){
      print("erro app: " + error.toString() );
      setState(() {
        _mensagemErro = "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

          width: MediaQuery.of(context).size.width ,
          height: MediaQuery.of(context).size.height  ,
          decoration: BoxDecoration(
            //gradiente
              
          ),
          child: Center(
                  //esse codigo cria um retangulo no meio da tela
                  child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Container(
                      
                      
                      child: Column(
                          children: <Widget>[
                             Row(children: <Widget>[
                              SizedBox(width: 30,),
                              
                              GestureDetector(onTap: ()=>{Navigator.pop(context)},child: Text("x",style: TextStyle(color: Colors.grey, fontSize: 30))),
                              SizedBox(width: 90,),
                                Text("Nova Conta",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30
                                ))
                              ],),

                            SizedBox(height: 40,),
                            CustomTextField(lable: 'Nome', keyboard: TextInputType.name,controller: this._controllerName,),
                            SizedBox(height: 20,),
                            CustomTextField(lable: 'Email', keyboard: TextInputType.emailAddress,controller: this._controllerEmail),
                            SizedBox(height: 20,),
                            CustomTextField(lable: 'Senha',password: true, controller: this._controllerPassword,),
                            SizedBox(height: 20,),
                            CustomButton(buttonText: "Sign Up", onPress: ()=>{this._onSeding()},),
                            // CustomButton(buttonText: "Volta", onPress: ()=>{),
                          ]
                      )
                  
                  )
              )
          )

      ),
    );;
  }
}
