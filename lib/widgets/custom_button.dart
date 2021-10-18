import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;

  CustomBtn({this.text,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Container(
          child: Center(
            child: Text(
              text ?? "Text",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400,color:Colors.black),
            ),
          )
      ),
    );
  }
}

