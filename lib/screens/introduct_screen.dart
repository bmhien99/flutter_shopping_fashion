import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/screens/home_page.dart';
import 'package:flutter_app_fashion/screens/landing_page.dart';
import 'package:flutter_app_fashion/screens/login_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductScreen extends StatelessWidget {
  List<PageViewModel> listPageView() {
    return [
      PageViewModel(
        title: "Free Shipping",
        body:
            " Free home delivery, thoughtful and dedicated...",
        image: Center(
          child: Image.asset("assets/Introduct/pop2.jpg",fit: BoxFit.cover,),
        ),
      ),
      PageViewModel(
        title: "Supper Sale To 80\%",
        body:
            "Shocking discounts on fashion items...",
        image: Center(
          child: Image.asset("assets/Introduct/pop3.jpg",fit: BoxFit.cover,),
        ),
      ),
      PageViewModel(
        title: "Online 24/24",
        body:
            "Shopping anytime, anywhere...",
        image: Container(
          width: double.infinity,
          height: 300.0,
          child: Center(
            child: Image.asset("assets/Introduct/pop.png",fit:BoxFit.cover),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: IntroductionScreen(
          pages: listPageView(),
          onDone: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LandingPage()));
          },
          onSkip: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LandingPage()));
          },
          showSkipButton: true,
          showDoneButton: true,
          showNextButton: true,
          next: Text("Next"),
          done: Text("Done"),
          skip: Text("Skip"),
        ),
      ),
    );
  }
}
