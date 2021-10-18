import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCategory extends StatelessWidget {
  final String? image;
  final int? color;
  final void Function()? onPressed;


  CustomCategory({this.image,this.color,this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Color(color!),
        child: Image.asset("$image",fit: BoxFit.cover,)
      ),
    );
  }
}
