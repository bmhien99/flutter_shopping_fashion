import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/screens/achives/list_product_achives.dart';
import 'package:flutter_app_fashion/screens/cart_page.dart';
import 'package:flutter_app_fashion/screens/categories/bag/list_product_category_bag.dart';
import 'package:flutter_app_fashion/screens/categories/dress/list_product_category_dress.dart';
import 'package:flutter_app_fashion/screens/home_page.dart';
import 'package:flutter_app_fashion/services/FirebaseServices.dart';
import 'package:flutter_app_fashion/widgets/product_color.dart';
import 'package:flutter_app_fashion/widgets/product_size.dart';

class ProductCategoryBagPage extends StatefulWidget {
  final String? name;
  final String? imagePath;
  final double? price;
  final String? productId;

  ProductCategoryBagPage(
      {this.imagePath, this.name, this.price, this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

int count = 1;

class _ProductPageState extends State<ProductCategoryBagPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  User _user = FirebaseAuth.instance.currentUser;



  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_user.uid)
        .collection("cartBag")
        .doc(widget.productId)
        .set({
      "size": _selectedProductSize,
      "name": _selectedName,
    });
  }

  String _selectedName="";
  String _selectedProductSize="0";

  Widget _buildImagePath() {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("CategoryBag")
            .doc(widget.productId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            DocumentSnapshot documentData = snapshot.data!;
            return Center(
              child: Container(
                width: 350,
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(11.0),
                    height: 270.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.network(
                      "${documentData['imagepath']}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildNameToDescription() {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("CategoryBag")
            .doc(widget.productId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            DocumentSnapshot documentData = snapshot.data!;

            return Column(
              children: [
                Container(
                  height: 50.0,
                  child: Text(
                    "${documentData['name']}",
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Container(
                    height: 50.0,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("\$ ${documentData['price']}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red)),
                            Text("Description",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
                      ],
                    )),
              ],
            );
          }
          return Container(
              height: 80.0,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.name!,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Text("\$ ${widget.price!}",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.red)),
                      Text("Description",
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                ],
              ));
        });
  }

  Widget _buildDescription() {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("CategoryBag")
            .doc(widget.productId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            DocumentSnapshot documentData = snapshot.data!;

            return Container(
              margin: EdgeInsets.only(top: 4.0),
              child: Wrap(children: [
                Text("${documentData['description']}",
                    style: TextStyle(fontSize: 16.0))
              ]),
            );
          }
          return Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Wrap(children: [
              Text("description adadadadadas", style: TextStyle(fontSize: 16.0))
            ]),
          );
        });
  }

  Widget _buildSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Text("Size",
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black))),
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("CategoryBag")
                .doc(widget.productId)
                .get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              DocumentSnapshot documentData = snapshot.data!;
              List productSizes = documentData['size'];
              _selectedProductSize = productSizes[0];
              return Container(
                child: Row(
                  children: [
                    ProductSize(
                      productSizes: productSizes,
                      onSelected: (size){
                        _selectedProductSize=size;
                      },

                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }

  // Widget _buildColor() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //           margin: EdgeInsets.only(top: 4.0),
  //           child: Text("Color",
  //               style: TextStyle(
  //                   fontSize: 17.0,
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.black))),
  //       Container(
  //         child: Row(
  //           children: [
  //             ProductColor(
  //               color: 0xff33FF00,
  //             ),
  //             ProductColor(
  //               color: 0xffFFFF00,
  //             ),
  //             ProductColor(
  //               color: 0xffFF0000,
  //             ),
  //             ProductColor(
  //               color: 0xffFF66FF,
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildQuanity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Text("Quantity",
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black))),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          height: 30.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (count > 0)
                      count--;
                    else
                      count = 0;
                  });
                },
                child: Icon(Icons.remove),
              ),
              Text("${count}", style: TextStyle(fontSize: 16.0)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    count++;
                  });
                },
                child: Icon(Icons.add),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBtnAddCart() {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("CategoryBag")
            .doc(widget.productId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                //.of(context).showSnackBar(_snackBar);
              },
              child: Container(
                margin: EdgeInsets.only(top: 8.0),
                height: 40.0,
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text("Add to Cart"),
                  onPressed: () async {
                    await _addToCart();
                  },
                  color: Color(0xfff2f2f2),
                ),
              ),
            );

          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildTotal() {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("CategoryBag")
            .doc(widget.productId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            DocumentSnapshot documentData = snapshot.data!;

            return Container(
              margin: EdgeInsets.only(top: 4.0),
              child: Row(children: [
                Text("Total:",
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                Text("${documentData['total']}",
                    style: TextStyle(fontSize: 16.0))
              ]),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListCategoryBag()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ListProductAchives()));
            },
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImagePath(),
                  _buildNameToDescription(),
                  _buildDescription(),
                  _buildSize(),
                  _buildTotal()
                  //_buildColor(),
                  //_buildQuanity(),
                  //_buildBtnAddCart(),
                ],
              ),
            ],
          )),
    );
  }
}
