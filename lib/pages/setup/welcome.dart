import 'package:flutter/material.dart';
import 'package:mombook/pages/setup/sign_in.dart';
import 'package:mombook/pages/setup/sign_up.dart';
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
              image: new AssetImage("assets/images/pregnancy.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            AppBar(
              backgroundColor: new Color.fromRGBO(5, 4, 4, 0.5),
              centerTitle: true,
              title: Text("Welcome to mombook" + box.toString()),
            )
          ],
        ),
        Center(
          child: Container(
            alignment: Alignment.bottomCenter,
              width: box,
              height: 200,
              color: Color.fromRGBO(5, 4, 4, 0.5),
              child: Column(

                children: <Widget>[
                  Center(
                      child:
                      Text(
                    "Hello Mom.",
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ))
                  ,
                  Container(
                    height: 160,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                        Column(

                            children: <Widget>[
                                RaisedButton(
                                  onPressed: navigateToSignIn,
                                  child: Text('Sign in'),
                                ),

                            ]),
                        Column(children: <Widget>[
                          RaisedButton(
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
