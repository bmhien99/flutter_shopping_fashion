import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/contants.dart';
import 'package:flutter_app_fashion/screens/achives/product_achives_page.dart';
import 'package:flutter_app_fashion/screens/cart_page.dart';
import 'package:flutter_app_fashion/screens/home_page.dart';
import 'package:flutter_app_fashion/services/FirebaseServices.dart';
import 'package:flutter_app_fashion/widgets/custom_input.dart';
import 'package:flutter_app_fashion/widgets/product_card_achives.dart';

class ListProductAchives extends StatefulWidget {
  const ListProductAchives({Key? key}) : super(key: key);

  @override
  _ListProductAchivesState createState() => _ListProductAchivesState();
}

class _ListProductAchivesState extends State<ListProductAchives> {

  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  // Widget _search(){
  //   return Container(
  //     child: Center(
  //       child: Stack(
  //         children: [
  //           if (_searchString.isEmpty)
  //             Center(
  //               child: Text(
  //                 "Search Results",
  //                 style: Contants.regularHeading,
  //               ),
  //             )
  //           else
  //             FutureBuilder<QuerySnapshot>(
  //               future: FirebaseFirestore.instance.collection("achives")
  //                   .orderBy("search_string")
  //                   .startAt([_searchString])
  //                   .endAt(["$_searchString\uf8ff"])
  //                   .get(),
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasError) {
  //                   return Scaffold(
  //                     body: Text("Error: ${snapshot.hasError}"),
  //                   );
  //                 }
  //                 //Collection data
  //                 if (snapshot.connectionState == ConnectionState.done) {
  //                   return Container(
  //                     margin: EdgeInsets.symmetric(horizontal:7.0,vertical: 80.0),
  //                     child: ListView(
  //                       children: [
  //                         Column(
  //                           children: [
  //                             GridView.count(
  //                               crossAxisCount: 2,
  //                               crossAxisSpacing: 10,
  //                               childAspectRatio: 0.8,
  //                               scrollDirection: Axis.vertical,
  //                               children: snapshot.data!.docs.map((e) {
  //                                 return ProductCardAchives(
  //                                   title: e.data()['name'],
  //                                   imageUrl: e.data()['imagepath'],
  //                                   price: "\$ ${e.data()['price']}",
  //                                   productId: e.id,
  //                                 );
  //                               }).toList(),
  //                             ),
  //
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 }
  //                 //Loading State
  //                 return Scaffold(
  //                   body: Center(
  //                     child: CircularProgressIndicator(),
  //                   ),
  //                 );
  //               },
  //             ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 10.0),
  //             child: CustomInput(
  //               name: "Search here...",
  //               onChanged: (value) {
  //                 if (value!.isNotEmpty) {
  //                   setState(() {
  //                     _searchString = value.toLowerCase();
  //                   });
  //                 }
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                if (_searchString.isEmpty)
                  Center(
                    child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("achives")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 7.0, vertical: 80.0),
                              child: ListView(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 700.0,
                                        child: GridView.count(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 0.8,
                                          scrollDirection: Axis.vertical,
                                          children: snapshot.data!.docs.map((
                                              e) {
                                            return ProductCardAchives(
                                              title: e.data()['name'],
                                              imageUrl: e.data()['imagepath'],
                                              price: "\$ ${e.data()['price']}",
                                              productId: e.id,
                                            );
                                          }).toList(),
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                    ),
                  )
                else
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection("achives")
                        .orderBy("search_string")
                        .startAt([_searchString])
                        .endAt(["$_searchString\uf8ff"])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Scaffold(
                          body: Text("Error: ${snapshot.hasError}"),
                        );
                      }
                      //Collection data
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 7.0, vertical: 80.0),
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 700.0,
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 0.8,
                                      scrollDirection: Axis.vertical,
                                      children: snapshot.data!.docs.map((e) {
                                        return ProductCardAchives(
                                          title: e.data()['name'],
                                          imageUrl: e.data()['imagepath'],
                                          price: "\$ ${e.data()['price']}",
                                          productId: e.id,
                                        );
                                      }).toList(),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      //Loading State
                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: CustomInput(
                    name: "Search here...",
                    onChanged: (value) {
                      if (value!.isNotEmpty) {
                        setState(() {
                          _searchString = value.toLowerCase();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

          ],
        ),),
    );
  }
}
