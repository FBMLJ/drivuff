// componentes de TextInput feito para otimizar o codigo e concentra toda logica nesse arquivo
import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String lable;
  final bool password;
  CustomTextField({Key key,this.lable, this.password=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: TextField(
          obscureText: this.password,
          decoration: InputDecoration(
            labelText: this.lable,
              contentPadding:  EdgeInsets.only(left: 20.0)
          ),
        ),
      )

    );
  }
}
