import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/screens/achives/product_achives_page.dart';
import 'package:flutter_app_fashion/screens/home_page.dart';
import 'package:flutter_app_fashion/services/FirebaseServices.dart';
import 'package:flutter_app_fashion/widgets/product_card_achives.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color:Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserId())
                  .collection("cart")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Text("Error: ${snapshot.hasError}"),
                  );
                }

                //Collection data
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductAchivesPage(
                                          productId: document.id,
                                        )));
                          },
                          child: FutureBuilder<dynamic>(
                            future: FirebaseFirestore.instance
                                .collection("achives")
                                .doc(document.id)
                                .get(),
                            builder: (context, productSnap) {
                              Map _product = productSnap.data!.data();
                              if(productSnap.hasError)
                                {
                                  return Container(
                                    child:CircularProgressIndicator(),
                                  );
                                }
                              if(snapshot.connectionState==ConnectionState.done)
                              {
                                return Card(
                                  child: Container(
                                    height: 150,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(
                                            "${_product["imagepath"]}",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          height: 130.0,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    //margin: EdgeInsets.only(top:5.0 ),
                                                      child: Text("${_product['name']}",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.black))),
                                                ),
                                                Expanded(child: Text("Size - ${document.data()['size']}")),
                                                Expanded(
                                                  child: Text("\$ ${_product['price']}",
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.red)),
                                                ),
                                                // Expanded(
                                                //   child: Container(
                                                //     margin: EdgeInsets.only(top: 4.0),
                                                //     height: 30.0,
                                                //     width: 90.0,
                                                //     decoration: BoxDecoration(
                                                //       color: Color(0xfff2f2f2),
                                                //       borderRadius: BorderRadius.circular(14.0),
                                                //     ),
                                                //     child: Row(
                                                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                //       children: [
                                                //         GestureDetector(
                                                //           onTap: () {
                                                //             setState(() {
                                                //               if (count > 0)
                                                //                 count--;
                                                //               else
                                                //                 count = 0;
                                                //             });
                                                //           },
                                                //           child: Icon(Icons.remove),
                                                //         ),
                                                //         Text("${count}", style: TextStyle(fontSize: 16.0)),
                                                //         GestureDetector(
                                                //           onTap: () {
                                                //             setState(() {
                                                //               count++;
                                                //             });
                                                //           },
                                                //           child: Icon(Icons.add),
                                                //         )
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                child:CircularProgressIndicator(),
                              );
                            },
                          ));
                    }).toList(),
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
          ],
        ),
      ),
    );
  }
}
