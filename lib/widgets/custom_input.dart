import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/screens/login_page.dart';

class CustomInput extends StatelessWidget {
  final String? name;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final void Function()? onTap;

  CustomInput({ this.name,this.validator, this.onChanged,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
            hintText: name,
            border: OutlineInputBorder(),
            )
        ),
    );
  }
}

