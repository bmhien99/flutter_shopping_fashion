import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_fashion/screens/cart_page.dart';
import 'package:flutter_app_fashion/screens/home_page.dart';
import 'package:flutter_app_fashion/screens/login_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _homeColor = true;
  bool _contactColor = false;
  bool _logoutColor = false;
  bool _cartColor = false;
  bool _aboutColor = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // UserAccountsDrawerHeader(
          //   accountName: Text("bui minh hien"),
          //   accountEmail: Text("bmhien99@gmail.com"),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: AssetImage("assets/account.png"),
          //   ),
          // ),
          ListTile(
            selected: _homeColor,
            onTap: () {
              setState(() {
                _homeColor = true;
                _cartColor = false;
                _contactColor = false;
                _logoutColor = false;
                _aboutColor = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            selected: _cartColor,
            onTap: () {
              setState(() {
                _cartColor = true;
                _contactColor = false;
                _logoutColor = false;
                _aboutColor = false;
                _homeColor = false;
              });
              Navigator.push(context,MaterialPageRoute(
                builder: (context) => CartPage()));
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
          ),
          ListTile(
            selected: _aboutColor,
            onTap: () {
              setState(() {
                _aboutColor = true;
                _cartColor = false;
                _contactColor = false;
                _logoutColor = false;
                _homeColor = false;
              });
              //Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
            },
            leading: Icon(Icons.info),
            title: Text("About"),
          ),
          ListTile(
            selected: _contactColor,
            onTap: () {
              setState(() {
                _contactColor = true;
                _aboutColor = false;
                _homeColor = false;
                _cartColor = false;
                _logoutColor = false;
              });
              //Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
            },
            leading: Icon(Icons.phone),
            title: Text("Contact Us"),
          ),
          ListTile(
            selected: _logoutColor,
            onTap: () {
              setState(() {
                _cartColor = false;
                _contactColor = false;
                _aboutColor = false;
                _homeColor = false;
              });
              Navigator.push(context,MaterialPageRoute(
                  builder: (context) => LoginPage()));
              FirebaseAuth.instance.signOut();
              },
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),

          ),
        ],
      ),
    );
  }
}
