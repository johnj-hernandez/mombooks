import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mombooks/model.dart';

class NoteFirebase extends StatefulWidget {
  const NoteFirebase({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<NoteFirebase> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _titulo, _descripcion, _fecha, _public, _hour;

  Future<NoteFB> saveNote(String title, String descripcion, String fecha,
      String public, String hour) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(Firestore.instance.collection('notes').document());

      var dataMap = new Map<String, dynamic>();
      dataMap['titulo'] = title;
      dataMap['descripcion'] = descripcion;
      dataMap['date'] = new DateTime.now();
      dataMap['uid'] = widget.user.uid;
      dataMap['fecha'] = fecha;
      dataMap['public'] = public;
      dataMap['hour'] = hour;


      await tx.set(ds.reference, dataMap);

      return dataMap;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return NoteFB.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

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
                iconTheme: IconThemeData(color: Colors.purple),
                backgroundColor: new Color.fromRGBO(255, 255, 255, 0.7),
                centerTitle: true,
                title: Text(
                  "Sign up",
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ]),
            Center(
                child: Container(
                    child: Center(
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          width: box,
                          height: 300,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)),
                              color: Color.fromRGBO(255, 255, 255, 0.7)),
                          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                          //color: Color.fromRGBO(5, 4, 4, 0.5),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Bienvenido',
                                    style:
                                    TextStyle(
                                        color: Colors.purple, fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.purple),
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Por favor digita un titulo de nota';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Titulo',
                                      labelStyle: TextStyle(
                                          color: Colors.purple),
                                      fillColor: Colors.purple,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    onSaved: (input) => _titulo = input,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RaisedButton(
                                    splashColor: Colors.purple,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                    textColor: Colors.purple,
                                    highlightColor: Colors.purple,
                                    onPressed:(){ saveNote(_titulo, "test","d","","");},
                                    child: Text('Sign up'),
                                  ),
                                ],
                              ))),
                    )))
          ],
        ));
  }
}
