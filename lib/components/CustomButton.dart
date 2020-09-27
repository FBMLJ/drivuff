import 'package:flutter/material.dart';

/*
* Esse componente para colocar os botões do aplicativo para isso precisa preencher os seguintes atributos
* buttonText: o texto do botão(String)
* buttonColor: a cor do botão(Colors)
* textColor: a cor do texto(Colors)
* onPress: a função que será executada quando o botão for clicado
*/
class CustomButton extends StatelessWidget {
  //atributos
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final onPress;
  const CustomButton({Key key, this.buttonText, this.buttonColor=Colors.lightGreen, this.textColor=Colors.white, this.onPress }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
          color: this.buttonColor,
          onPressed: this.onPress,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: this.buttonColor),
          ),
          child: Text(
            this.buttonText,
            style: TextStyle(
              color: this.textColor,
              fontSize: 15
            ),
          ),
        )
    );
  }
}
