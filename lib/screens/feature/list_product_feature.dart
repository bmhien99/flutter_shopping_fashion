import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/screens/home_page.dart';
import 'package:flutter_app_fashion/widgets/product_card_feature.dart';


class ListProductFeature extends StatefulWidget {
  const ListProductFeature({Key? key}) : super(key: key);

  @override
  _ListProductFeatureState createState() => _ListProductFeatureState();
}

class _ListProductFeatureState extends State<ListProductFeature> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color:Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
          ),
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.search,color: Colors.blue,),
            // ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.notifications_none,color: Colors.black87,),
            // )
          ],
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("feature")
                .get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting)
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.connectionState==ConnectionState.done)
              {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal:7.0,vertical: 7.0),
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
                                return ProductCardFeature(
                                  title: e.data()['name'],
                                  imageUrl: e.data()['imagepath'],
                                  price: "\$${e.data()['price']}",
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
        ),),
    );
  }
}
