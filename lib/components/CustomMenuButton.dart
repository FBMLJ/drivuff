import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/*
* Esse componente para colocar os botões do aplicativo para isso precisa preencher os seguintes atributos
* buttonText: o texto do botão(String)
* buttonColor: a cor do botão(Colors)
* textColor: a cor do texto(Colors)
* onPress: a função que será executada quando o botão for clicado
*/
class CustomMenuButton extends StatelessWidget {
  //atributos
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final onPress;
  final String image;
  const CustomMenuButton({Key key, this.buttonText, this.buttonColor=Colors.transparent, this.textColor=Colors.black, this.onPress, this.image="" }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
          width: double.infinity,
          height: 60,
          child: FlatButton(
            color: this.buttonColor,
            onPressed: this.onPress,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  this.buttonText,
                  style: TextStyle(
                    color: this.textColor,
                    fontSize: 15
                  ),
                ),
                Container(width: 20,),
                SvgPicture.asset("imagens/logout.svg", color: Colors.red,width: 30,height: 30,),

              ],
            )

          )
      )

    );
  }
}
