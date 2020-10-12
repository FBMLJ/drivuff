import 'package:flutter/material.dart';
import '../components/CustomButton.dart';
import '../components/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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


    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(email: email, password: password)
        //será executado se conseguir criar um usuario
        .then((value) => {print("sucesso")
    })
        //será executado quando falhar em criar um usuario
        .catchError((e)=>print("falha"));

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
                            CustomButton(buttonText: "Enviar", onPress: ()=>{_validarCampos()},),
                            CustomButton(buttonText: "Volta", onPress: ()=>{Navigator.pop(context)
                            }),
                            Text(_mensagemErro, style: TextStyle(color: Colors.red, fontSize: 14)),
                            Text(_mensagemSucesso, style: TextStyle(color: Colors.blue, fontSize: 14)),
                          ]
                      )
                  )
              )
          )

      ),
    );;
  }
}
