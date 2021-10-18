import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/screens/home_page.dart';
import 'package:flutter_app_fashion/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: _initialization,
          builder: (context,snapshot)
          {
            if(snapshot.hasError){
              return Scaffold(
                body: Text("Error: ${snapshot.error}"),
              );
            }
            if(snapshot.connectionState==ConnectionState.done)
            {
              return StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context,streamSnapshot)
                  {
                    if(snapshot.hasError)
                    {
                      return Scaffold(
                        body: Text("Error: ${snapshot.hasError}"),
                      );
                    }
                    if(streamSnapshot.connectionState==ConnectionState.active){
                      //Lay User
                      Object? _user=streamSnapshot.data;
                      if(_user==null)
                      {
                        return LoginPage();
                      }
                      else{
                        return HomePage();
                      }
                    }
                    return Scaffold(
                        body: Container(
                            child: Center(
                              child: Text("Check auth"),
                            )));
                  }

              );
            }
            return Scaffold(


                body: Container(
                    child: Center(
                      child: Text("FireBase intialization..."),
                    )));
          }
    );
  }
}
//return FutureBuilder(
//         future: _initialization,
//         builder: (context,snapshot)
//         {
//           if(snapshot.hasError){
//             return Scaffold(
//               body: Text("Error: ${snapshot.error}"),
//             );
//           }
//           //Firebase App dang chay
//           if(snapshot.connectionState==ConnectionState.done)
//           {
//             //Streambuilder check trang thai cua login
//             return StreamBuilder(
//                 stream: FirebaseAuth.instance.authStateChanges(),
//                 builder: (context,streamSnapshot)
//                 {
//                   if(snapshot.hasError)
//                   {
//                     return Scaffold(
//                       body: Text("Error: ${snapshot.hasError}"),
//                     );
//                   }
//                   //Ket noi thanh cong va lay ra user
//                   if(streamSnapshot.connectionState==ConnectionState.active){
//                     //Lay User
//                     Object? _user=streamSnapshot.data;
//                     if(_user==null)
//                     {
//                       return LoginPage();
//                     }
//                     else{
//                       return HomePage();
//                     }
//                   }
//                   return Scaffold(
//                       body: Container(
//                           child: Center(
//                             child: Text("Check auth"),
//                           )));
//                 }
//
//             );
//           }
//           return Scaffold(
//
//
//               body: Container(
//                   child: Center(
//                     child: Text("FireBase intialization..."),
//                   )));
//         }
//     );