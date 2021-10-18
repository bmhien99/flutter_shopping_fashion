import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/contants.dart';
import 'package:flutter_app_fashion/screens/achives/product_achives_page.dart';
import 'package:flutter_app_fashion/screens/feature/product_feature_page.dart';

class ProductCardAchives extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? price;
  final String? productId;
  final void Function()? onPressed;

  ProductCardAchives({this.imageUrl, this.title, this.price, this.productId, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductAchivesPage(productId: productId ,)));
      },
      child: Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Container(
                  height: 220,
                  width: 180,
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 120,
                        child:Image.network("$imageUrl",fit: BoxFit.cover,),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4.0),
                        child: Column(
                          children: [
                            Text(
                              title!,style: Contants.regularHeading,
                            ),
                            Text(
                              price!,style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
