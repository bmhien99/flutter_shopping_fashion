

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_fashion/widgets/custom_button.dart';
import 'package:flutter_app_fashion/widgets/custom_inout_password.dart';
import 'package:flutter_app_fashion/widgets/custom_input.dart';
import 'package:flutter_app_fashion/screens/login_page.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);



class _SignUpState extends State<SignUp> {

  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Error"),
        content: Container(
          child: Text(error),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Close Dialog",style: TextStyle(color: Colors.cyan),),
          )
        ],
      );
    });
  }
  Future<String?> _createAccount() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _registerEmail, password: _registerPassword);
      return null;
    }
    on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    }
    catch(e)
    {
      return e.toString();
    }
  }
  void validation() async {
    final FormState? _form = _formKey.currentState;
    if (!_form!.validate()) {

    } else {
      print("no");
    }

    String? _createAccountFeetback=await _createAccount();
    if(_createAccountFeetback !=null)
    {
      _alertDialogBuilder(_createAccountFeetback);
      setState(() {
        _registerFormLoading=false;
      });
    }
    else{
      Navigator.pop(context,MaterialPageRoute(builder: (context)=>LoginPage()));
    }
  }

  String? _registerEmail;
  String? _registerPassword;
  bool _registerFormLoading=false;

  @override
  Widget build(BuildContext context) {
    bool _obserText=true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(top: 40.0),
                      child: Center(
                          child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )),
                    )),
                Flexible(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 7.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomInput(
                            name:"UserName",
                            validator: (value) {
                              if (value!.length < 6) {
                                return "Please Is Too Short";
                              } else if (value == "") {
                                return "Please Fill UserName";
                              }
                              return "";
                            },

                          ),
                        ),
                        Expanded(
                          child: CustomInput(
                            name:"Email",
                            onChanged: (value){
                              setState(() {
                                _registerEmail=value;
                              });
                            },
                            validator: (value) {
                              if (value == "") {
                                return "Please Fill Email";
                              } else if (!regExp.hasMatch(value!)) {
                                return "Email Is Invalid";
                              }
                              return "";
                            },

                          ),
                        ),
                        Expanded(
                          child: CustomInPutPassword(
                            obstext: _obserText,
                            name:"Password",
                            validator: (value) {
                              if (value!.length < 8) {
                                return "Password Is Too short";
                              } else if (value == "") {
                                return "Please Fill Password";
                              }
                              return "";
                            },
                            onChanged: (value){
                              setState(() {
                                _registerPassword=value;
                              });
                            },
                            onTap: () {
                              setState(() {
                                _obserText=!_obserText;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.length != 11) {
                                return "Phone number must be 11";
                              }
                              return "";
                            },
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        CustomBtn(
                          text: "Register",
                          onPressed: validation,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Text("I Have Already on Account! ",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
                          },
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
