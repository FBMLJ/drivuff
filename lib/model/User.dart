import 'package:flutter/material.dart';
class UserModel{
  String name, email, password;
  //uma lista de erros que podem ser encontrados o primeiro nome, o segundo  email e o terceiro senha
  List errorsMessage = ["","",""];
  UserModel(this.name,this.email,this.password );

  bool validateDateLogin(){
    bool auxValue = true;

    //se o nome tiver vazio
    if (this.email.isEmpty){
      auxValue =false;
      errorsMessage[1]= "Email não informado";
    }
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      auxValue = false;
      errorsMessage[1] = "Esse email é invalido";
    }

    if (this.password.isEmpty ){
      auxValue = false;
      errorsMessage[2]="Senha não informada";
    }
    if (this.password.length < 6 && this.password.length!= 0){
      auxValue = false;
      errorsMessage[2]="Senha muito curta";
    }
    return auxValue;
  }

  bool validateDateRegister(){
    bool auxValue = true;
    auxValue = validateDateLogin();
    if (this.name.isEmpty){
      auxValue = false;
      errorsMessage[0] = "Nome não informado";
    }
    return auxValue;
  }
}