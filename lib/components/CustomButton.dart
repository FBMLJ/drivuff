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
  const CustomButton({Key key, this.buttonText, this.buttonColor=Colors.green, this.textColor=Colors.white, this.onPress }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child:FractionallySizedBox(
        widthFactor: 0.8,
          child: RaisedButton(
            color: this.buttonColor,
            onPressed: this.onPress,
            
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: this.buttonColor),
            ),
            child: Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 12),
              child: Text(
                this.buttonText,
                style: TextStyle(
                  color: this.textColor,
                  fontSize: 15
                ),
              ),
            )
          )
      )
    );
  }
}
