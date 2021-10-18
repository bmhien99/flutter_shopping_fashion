

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/widgets/custom_button.dart';
import 'package:flutter_app_fashion/widgets/custom_inout_password.dart';
import 'package:flutter_app_fashion/widgets/custom_input.dart';
import 'package:flutter_app_fashion/screens/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);


class _LoginPageState extends State<LoginPage> {


  void validation() async {
    final FormState? _form = _formKey.currentState;
    if (!_form!.validate()) {

    } else {
      print("no");
    }

    String? _createAccountFeetback=await _loginAccount();
    if(_createAccountFeetback !=null)
    {
      _alertDialogBuilder(_createAccountFeetback);
      setState(() {
        //_registerFormLoading=false;
      });
    }
    else{
      Navigator.pop(context);
    }
  }
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

  Future<String?> _loginAccount() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _loginEmail, password: _loginPassword);
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

  void _submitForm() async {
    setState(() {
      _loginFormLoading=true;
    });

    String? _signinFeedback=await _loginAccount();
    if(_signinFeedback !=null)
    {
      _alertDialogBuilder(_signinFeedback);
      setState(() {
        _loginFormLoading=false;
      });
    }
    else{
      Navigator.pop(context);
    }
  }


  bool _loginFormLoading=false;


  String? _loginEmail;
  String? _loginPassword;

  late FocusNode _passwordFocusnode;

  @override
  void initState() {
    _passwordFocusnode=FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    _passwordFocusnode.dispose();
    super.dispose();
  }
  bool _obserText=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )),
              )),
          Flexible(
            flex: 3,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  CustomInput(
                    name:"Email",
                    validator: (value) {
                      if (value == "") {
                          return "Please Fill Email";
                        } else if (!regExp.hasMatch(value!)) {
                          return "Email Is Invalid";
                        }
                        return "";
                      },
                    onChanged: (value){
                      _loginEmail=value;
                    },
                    ),
                  CustomInPutPassword(
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
                        _loginPassword=value;
                      });
                    },
                    onTap: () {
                      setState(() {
                        _obserText=!_obserText;
                      });
                    },
                  ),
                  CustomBtn(
                    text: "Login",
                    onPressed: _submitForm,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20,left: 10.0),
                    child: Row(
                      children: [
                        Text("I Have not Account! ",
                            style:
                            TextStyle(fontSize: 14, color: Colors.black)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
                          },
                          child: Text("Register",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

