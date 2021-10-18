import 'package:flutter/material.dart';

class ProductColor extends StatelessWidget {
  final int? color;

  ProductColor({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10.0,right: 10.0),
      height: 45.0,
      width: 45.0,
      color: Color(color!),
      alignment: Alignment.center,
    );
  }
}
