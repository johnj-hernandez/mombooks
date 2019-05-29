import 'package:firebase_auth/firebase_auth.dart';
import 'package:mombooks/pages/home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
////////
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
                  image: new AssetImage("assets/images/login.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(children: <Widget>[
              AppBar(
                iconTheme: IconThemeData(
                  color: Colors.purple
                ),
                backgroundColor: new Color.fromRGBO(255, 255, 255, 0.7),
                centerTitle: true,
                title: Text("Sign in",style: TextStyle(color: Colors.purple),),
              ),
            ]),
            Center(
                child: Container(
                    child:
                    Center(
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          width: box,
                          height: 300,
                          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                          //color: Color.fromRGBO(255, 255, 255, 0.5),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color.fromRGBO(255, 255, 255, 0.7)
                          ),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Text('Bienvenido',style: TextStyle(color: Colors.purple,fontSize: 24),),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    autocorrect: false,
                                    style: TextStyle(color: Colors.purple),
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Por favor digita un correo';
                                      }
                                    },
                                    decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.purple),
                                      fillColor: Colors.purple,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),

                                    ),
                                    onSaved: (input) => _email = input,
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    autocorrect: false,
                                    style: TextStyle(color: Colors.purple),
                                    validator: (input) {
                                      if (input.length < 6) {
                                        return 'Su contraseña debe ser de al menos 6 caracteres';
                                      }
                                    },
                                    decoration:
                                    InputDecoration(labelText: 'Contraseña',labelStyle: TextStyle(color: Colors.purple),
                                      fillColor: Colors.purple,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                    ),
                                    onSaved: (input) => _password = input,
                                    obscureText: true,

                                  ),
                                  RaisedButton(
                                    splashColor: Colors.purple,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    textColor: Colors.purple,
                                    highlightColor: Colors.purple,
                                    onPressed: signIn,
                                    child: Text('Sign in'),
                                  ),
                                ],
                              ))),
                    )

                ))
          ],
        ));
  }

  void signIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
      }catch(e){
        print(e.message);
        //muestra el error en consola cuando se pone una contraseña incorrecta.
      }
    }
  }
}