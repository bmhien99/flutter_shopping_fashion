import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List? imageList;

  ImageSwipe({this.imageList});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300.0,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                setState(() {
                  _selectPage = value;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList!.length; i++)
                  Container(
                    child: Image.network(
                      "${widget.imageList![i]}",
                      fit: BoxFit.cover,
                    ),
                  )
              ],
            ),
            Positioned(
              bottom: 15.0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.imageList!.length; i++)
                    AnimatedContainer(
                      duration: Duration(microseconds: 300),
                      curve: Curves.easeOutCubic,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: _selectPage == i ? 25.0 : 10.0,
                      height: 6.0,
                      color: Colors.white,
                    ),
                ],
              ),
            )
          ],
        ));
  }
}
