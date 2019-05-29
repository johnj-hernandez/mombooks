import 'package:flutter/material.dart';
import 'package:mombooks/pages/setup/sign_in.dart';
import 'package:mombooks/pages/setup/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double box = width * 0.80;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/login-3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            AppBar(
              backgroundColor: new Color.fromRGBO(255, 255, 255, 0.7),
              centerTitle: true,
              title: Text("Welcome to mombook", style: TextStyle(
                color: Colors.purple
              ),),
            )
          ],
        ),
        Center(
          child: Container(
              alignment: Alignment.bottomCenter,
              width: box,
              height: 200,
              //color: Color.fromRGBO(255, 255, 255, 0.7),
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color.fromRGBO(255, 255, 255, 0.7)
              ),
              child: Stack(

                children: <Widget>[
                  Container(
                    width: box,
                      child:

                      Text(
                        "Hello Mom.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.purple, fontSize: 32),
                      ))
                  ,
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                      height: 160,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(

                                children: <Widget>[
                                  RaisedButton(
                                    splashColor: Colors.blue,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    textColor: Colors.purple,
                                    highlightColor: Colors.white,
                                    onPressed: navigateToSignIn,
                                    child: Text('Sign in'),
                                  ),

                                ]),
                            Column(children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.blue,
                                elevation: 10,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                textColor: Colors.purple,
                                highlightColor: Colors.white,

                                onPressed: navigateToSignUp,
                                child: Text('Sign up'),
                              )
                            ]),
                          ]))
                ],
              )),
        )
      ]),
    );
    // ...
    /*mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          RaisedButton(
            onPressed: navigateToSignIn,
            child: Text('Sign in'),
          ),
          RaisedButton(
            onPressed: navigateToSignUp,
            child: Text('Sign up'),
          ),
        ],*/
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}
