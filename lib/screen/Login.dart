import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../components/CustomTextField.dart';
import '../components/CustomButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/Usuario.dart';

//codigo responsavel pelo exibição da tela de login
class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key);
  @override

  final String title;
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //atributos
  TextEditingController _controllerEmail = TextEditingController(text: "");
  TextEditingController _controllerSenha = TextEditingController(text: "");
  String _mensagemErro = "";

  //metodos

  _sendForm(){
    print(this._controllerSenha.text);
    print(this._controllerEmail.text);
  }

  _validarCampos(){

    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if( email.isNotEmpty && email.contains("@") ){

      if( senha.isNotEmpty ){

        setState(() {
          _mensagemErro = "";
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario( usuario );


      }else{
        setState(() {
          _mensagemErro = "Preencha a senha!";
        });
      }

    }else{
      setState(() {
        _mensagemErro = "Preencha o E-mail utilizando @";
      });
    }

  }

  _logarUsuario( Usuario usuario ){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      Navigator.pushReplacementNamed(context, "/home");

    }).catchError((error){

      setState(() {
        _mensagemErro = "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
      });

    });

  }

  Future _verificarUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    //auth.signOut();

    User usuarioLogado = await auth.currentUser;

    if(usuarioLogado == null){
      Navigator.pushReplacementNamed(context, "/home");
    }

  }

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                          Text("Login", style: TextStyle(
                              color: Colors.white,
                              fontSize: 30
                            )),
                          CustomTextField(lable: 'Email', keyboard: TextInputType.emailAddress,controller: this._controllerEmail,),
                          CustomTextField(lable: 'Senha',password: true,controller: this._controllerSenha,),
                          CustomButton(buttonText: "Enviar", onPress: (){_validarCampos();},),
                          CustomButton(buttonText: "Cadastre-se", onPress: ()=>{Navigator.pushNamed(context,'/cadastro')
                          }),
                          Text(_mensagemErro, style: TextStyle(color: Colors.red, fontSize: 14)),
                        ]
                    )
                  )
                )
          )

        ),
    );
  }
}
