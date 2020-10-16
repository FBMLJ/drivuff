// componentes de TextInput feito para otimizar o codigo e concentra toda logica nesse arquivo
import 'package:flutter/material.dart';


/*
*  Esse componente serve para colocar um TextInput no codigo
*  Ele possui as seguintes atributos para serem fornecido
*   -label = o texto que aparecerá quando o texto tiver vazio (String)
*   -keyboard = o tipo de keyboard que vai aparecer quando digitar nesse campo TextInputType()
*   -password = deve ser colocado verdadeiro se o campo for um campo de senha (bool)
*   - controller = o controlador que será utilizado para controlar a edição do texto (TextEditingController)
*/
class CustomTextField extends StatelessWidget {
  //atributos
  final String lable;
  final bool password;
  final TextInputType keyboard;
  final TextEditingController controller;
  //construtor
  CustomTextField({Key key,this.lable, this.password=false, this.keyboard=TextInputType.text, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: TextField(
          controller: this.controller,
          keyboardType: this.keyboard,
          
          obscureText: this.password,
          decoration: InputDecoration(
            hintText: this.lable,
            fillColor: Color(0x44dddddd),
            filled: true,
              contentPadding:  EdgeInsets.only(left: 20.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0x88dddddd)),
              ),
              border:  OutlineInputBorder(
                borderSide: BorderSide(color: Color(0x88dddddd)),
              )
          ),
        ),
      )

    );
  }
}
