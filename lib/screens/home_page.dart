import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_fashion/contants.dart';
import 'package:flutter_app_fashion/screens/achives/list_product_achives.dart';
import 'package:flutter_app_fashion/screens/cart_page.dart';
import 'package:flutter_app_fashion/screens/categories/bag/list_product_category_bag.dart';
import 'package:flutter_app_fashion/screens/categories/dress/list_product_category_dress.dart';
import 'package:flutter_app_fashion/screens/categories/jean/list_product_category_jean.dart';
import 'package:flutter_app_fashion/screens/categories/shirt/list_product_category_shirt.dart';
import 'package:flutter_app_fashion/screens/categories/shoe/list_product_category_shoe.dart';
import 'package:flutter_app_fashion/screens/feature/list_product_feature.dart';
import 'package:flutter_app_fashion/widgets/custom_castegory.dart';
import 'package:flutter_app_fashion/screens/login_page.dart';
import 'package:flutter_app_fashion/widgets/custom_drawer.dart';
import 'package:flutter_app_fashion/widgets/image_swipe.dart';
import 'package:flutter_app_fashion/widgets/product_card_achives.dart';
import 'package:flutter_app_fashion/widgets/product_card_feature.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _buildCategory() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomCategory(
              image: "assets/category/dress.png",
              color: 0xff33dcfd,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListCategoryDress()));
              },
            ),
            CustomCategory(
              image: "assets/category/shirt.png",
              color: 0xff38cdd,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListCategoryShirt()));
              },
            ),
            CustomCategory(
              image: "assets/category/jean.png",
              color: 0xff4ff2af,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListCategoryJean()));
              },
            ),
            CustomCategory(
              image: "assets/category/shoe.png",
              color: 0xfff7acf7,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListCategoryShoe()));
              },
            ),
            CustomCategory(
              image: "assets/category/bag.png",
              color: 0xfffc6c8d,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListCategoryBag()));
              },
            ),
          ],
        ));
  }

  Widget _buildCarousel() {
    return Container(
      height: 300.0,
      child: Carousel(
        autoplay: true,
        showIndicator: false,
        images: [
          FutureBuilder(
            future: FirebaseFirestore.instance.collection("highlight").doc("XFRghGgHWhcwGxTpc9FV").get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              DocumentSnapshot data=snapshot.data!;
              List image=data['imagepath'];
              if(snapshot.connectionState==ConnectionState.done)
                {
                  return Container(
                    height: 300.0,
                    child: ImageSwipe(
                      imageList: image,
                    ),
                  );
                }


              return Container(
                child:CircularProgressIndicator(),
              );

            },
          )
        ],
      ),
    );
  }

//Container(
//                 height: 300.0,
//                 child: Carousel(
//                   // dotColor: Colors.white,
//                   // dotIncreasedColor: Colors.blue,
//                   autoplay: true,
//                   showIndicator: false,
//                   images: [
//                     Image.network("${data['imagepath']}",fit: BoxFit.cover,)
//                   ],
//                 ));

  Widget _buildFeatured() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          height: 30,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Featured",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListProductFeature()));
                    },
                    child: Text("See all",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ),
                ],
              )
            ],
          ),
        ),
        FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("feature").get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: snapshot.data!.docs.map((e) {
                      return ProductCardFeature(
                        title: e.data()['name'],
                        imageUrl: e.data()['imagepath'],
                        price: "\$${e.data()['price']}",
                        productId: e.id,
                      );
                    }).toList(),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ],
    );
  }

  Widget _buildAchives() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          height: 30,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shopping Now",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListProductAchives()));
                    },
                    child: Text("See all",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ),
                ],
              )
            ],
          ),
        ),
        FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("achives").get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: snapshot.data!.docs.map((e) {
                      return ProductCardAchives(
                        title: e.data()['name'],
                        imageUrl: e.data()['imagepath'],
                        price: "\$${e.data()['price']}",
                        productId: e.id,
                      );
                    }).toList(),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _key,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.send,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ListProductFeature()));
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          )
        ],
      ),
      body: FutureBuilder<dynamic>(
          future: FirebaseFirestore.instance.collection("achives").get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {}
            return Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        _buildCarousel(),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 7.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Gallery",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ])),
                        _buildCategory(),
                        _buildFeatured(),
                        _buildAchives(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
