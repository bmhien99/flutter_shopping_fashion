import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List? productSizes;
  final void Function(String)? onSelected;

  ProductSize({this.productSizes,this.onSelected});

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected=0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
      ),
      child: Row(
        children: [
          for(var i=0;i<widget.productSizes!.length;i++)
            GestureDetector(
              onTap: () {
                widget.onSelected!("${widget.productSizes![i]}");
                setState(() {
                  _selected=i;
                });
              },
              child: Container(
                width: 45.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: _selected==i?Theme.of(context).accentColor:Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text("${widget.productSizes![i]}",style: TextStyle(
                  color: _selected==i?Colors.white:Colors.black,
                ),),

              ),
            ),
        ],
      ),
    );
  }
}


