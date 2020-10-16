import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// importando o custom field
import '../components/CustomTextField.dart';
//importando o custom button
import '../components/CustomButton.dart';
import '../model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  void initState() {
    _verificarUsuarioLogado();
    print("Teste");
    super.initState();
  }



  //atributos
  TextEditingController _controllerEmail = TextEditingController(text: "");
  TextEditingController _controllerPassword = TextEditingController(text: "");
  //metodos
  _sendForm(){
    UserModel user = UserModel('', this._controllerEmail.text,this._controllerPassword.text);
    if (user.validateDateLogin()){

      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signInWithEmailAndPassword(email: user.email, password: user.password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false));
    }
    else{
      print("Error");
    }
  }


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
                          CustomTextField(lable: 'Senha',password: true,controller: this._controllerPassword,),
                          CustomButton(buttonText: "Enviar", onPress: (){this._sendForm();},),
                          CustomButton(buttonText: "Cadastre-se", onPress: ()=>{Navigator.pushNamed(context,'/cadastro')
                          }),
                        ]
                        
                    )
                  )
                
          )

        ),
    );
  }
}
