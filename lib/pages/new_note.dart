import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mombooks/model.dart';
import 'package:intl/intl.dart';
import 'package:mombooks/pages/home.dart';

class NoteFirebase extends StatefulWidget {
  const NoteFirebase({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<NoteFirebase> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<NoteFB> saveNote(String title, String descripcion, String fecha,
      bool public, String hour) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(Firestore.instance.collection('notes').document());
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      var formatterHour = new DateFormat('hh:mm');
      var dataMap = new Map<String, dynamic>();
      dataMap['titulo'] = title;
      dataMap['descripcion'] = descripcion;
      dataMap['date'] = new DateTime.now();
      dataMap['uid'] = widget.user.uid;
      dataMap['fecha'] = formatter.format(now);
      dataMap['public'] = public;
      dataMap['hora'] = formatterHour.format(now);


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

  final myController = TextEditingController();
  final description = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    myController.dispose();
    super.dispose();
    description.dispose();
    super.dispose();
  }
  String _titulo, _descripcion, _fecha,  _hour;
  bool _public = true;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    double box = width * 0.80;

    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: true,
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
                  "Nota",
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
                          height: 400,
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
                                    'Cree su nota',
                                    style:
                                    TextStyle(
                                        color: Colors.purple, fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: myController,
                                    style: TextStyle(color: Colors.purple),
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Por favor digita un titulo de la nota';
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
                                    onFieldSubmitted:  (input) => _titulo = input,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: description,
                                    style: TextStyle(color: Colors.purple),
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Por favor digita un descripcion de la nota';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Descripcion',
                                      labelStyle: TextStyle(
                                          color: Colors.purple),
                                      fillColor: Colors.purple,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    onFieldSubmitted:  (input) => _descripcion = input,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Publico"),
                                  Checkbox(
                                    value: _public,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _public = value;
                                      });
                                    },
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
                                    onPressed:(){
                                      print(_descripcion);
                                      print(myController);
                                      saveNote(myController.text, description.text,"2019-05-24",_public,"9:00");
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: this.widget.user)));},
                                    child: Text('Guardar'),
                                  ),
                                ],
                              ))),
                    )))
          ],
        ));
  }
}
