import 'package:firebase_auth/firebase_auth.dart';
import 'package:mombooks/pages/setup/sign_in.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double box = width * 0.80;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/baby.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(children: <Widget>[
              AppBar(
                backgroundColor: new Color.fromRGBO(5, 4, 4, 0.5),
                centerTitle: true,
                title: Text("Sign in"),
              ),
            ]),
            Center(
                child: Container(
                    child:
                    Center(
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          width: box,
                          height: 250,
                          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                          color: Color.fromRGBO(5, 4, 4, 0.5),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Text('Bienvenido',style: TextStyle(color: Colors.white,fontSize: 24),),
                                  TextFormField(

                                    style: TextStyle(color: Colors.white),
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Por favor digita un correo';
                                      }
                                    },
                                    decoration: InputDecoration(labelText: 'Email',
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),

                                    ),
                                    onSaved: (input) => _email = input,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    validator: (input) {
                                      if (input.length < 6) {
                                        return 'Su contraseña debe ser de al menos 6 caracteres';
                                      }
                                    },
                                    decoration:
                                    InputDecoration(labelText: 'Contraseña',fillColor: Colors.white,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                                    ),
                                    onSaved: (input) => _password = input,
                                    obscureText: true,

                                  ),
                                  RaisedButton(
                                    color: Colors.indigo,
                                    textColor: Colors.white,
                                    shape: Border(bottom: BorderSide(color: Colors.white)),
                                    elevation: box,
                                    highlightColor: Colors.white,
                                    onPressed: signUp,
                                    child: Text('Sign up'),
                                  ),
                                ],
                              ))),
                    )

                ))
          ],
        ));
  }

  void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }catch(e){
        print(e.message);
      }
    }
  }
}