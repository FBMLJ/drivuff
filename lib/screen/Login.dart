import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/CustomTextField.dart';
import '../components/CustomButton.dart';
import '../model/User.dart';
import '../components/Usuario.dart';


//codigo responsavel pelo exibição da tela de login
class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key);
  @override

  final String title;
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // confirma se o usuario não está logado
  Future _verificarUsuarioLogado()  async{

    FirebaseAuth auth = FirebaseAuth.instance;
    //auth.signOut();
    User usuarioLogado = await auth.currentUser;
    print(usuarioLogado);

    if( usuarioLogado != null ){
      Navigator.pushReplacementNamed(context, "/home");
    }

  }

  


  //atributos
  TextEditingController _controllerEmail = TextEditingController(text: "");
  TextEditingController _controllerSenha = TextEditingController(text: "");
  String _mensagemErro = "";

  //metodos

  _sendForm(){
    UserModel user = UserModel('', this._controllerEmail.text,this._controllerSenha.text);
    if (user.validateDateLogin()){

      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signInWithEmailAndPassword(email: user.email, password: user.password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false));
    }
    else{
      print("Error");
    }
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
            color: Colors.white,
            
            child: Center(
                  //esse codigo cria um retangulo no meio da tela
                  child: Container(
                   
                    width: MediaQuery.of(context).size.width *1 ,
                    height: MediaQuery.of(context).size.height *.75  ,

                    child: Column(
                        
                        children: <Widget>[
                          Text("Entrar", style: TextStyle(
                              color: Colors.black,
                              fontSize: 30
                            )),
                          Container(height: 150,), //esse container serve para simbolizar o logo
                          CustomTextField(lable: 'Email', keyboard: TextInputType.emailAddress,controller: this._controllerEmail,),
                          SizedBox(height: 10,),
                          CustomTextField(lable: 'Senha',password: true,controller: this._controllerSenha,),
                          SizedBox(height: 70,),
                          CustomButton(buttonText: "Log in", onPress: (){this._sendForm();},),
                          SizedBox(height: 15,),
                          GestureDetector(onTap: ()=>{Navigator.pushNamed(context,'/cadastro')},
                            child: Text("Criar Conta",style: TextStyle(color: Colors.green, fontSize: 18))),
                        ]
                        
                    )
                  )
                
          )

        ),
    );
  }
}
