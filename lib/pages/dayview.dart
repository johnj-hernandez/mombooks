import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mombooks/pages/new_note.dart';
import 'package:mombooks/pages/noteView.dart';

class DayView extends StatefulWidget {
  const DayView({Key key, this.user,this.fecha}) : super(key: key);
  final FirebaseUser user;
  final String fecha;

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text(widget.fecha),),
      body: CustomeStreamBuilder(context),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteFirebase(user: this.widget.user, fecha: widget.fecha)));
        },//mover al formulario de nueva nota
        child: Icon(Icons.add),
        tooltip: "Agregar nueva nota",
      ),
    );
  }
  Widget CustomeStreamBuilder(BuildContext context){
    String userID=this.widget.user.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("notes")
          .where("uid",isEqualTo: userID)
          .where("fecha",isEqualTo: this.widget.fecha).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          default:
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int i) =>
                  _buildRow(context, snapshot.data.documents[i]),
            );
        }
      },
    );
  }

  Widget _buildRow(BuildContext context, DocumentSnapshot document) {
    var sub= document['descripcion'].toString();
    sub=sub.length<40?sub:sub.substring(0,40);
    sub=sub+"....";
    String titulo=document["titulo"];
    String descripcion=document["descripcion"];
    String author=document["nombre"].toString() + "   "+document["apellido"].toString();
    return Material(
      child: Container(
        color: Colors.white70,
          margin:EdgeInsets.all(10),
          height: 60.0,
          child: ListTile(
            title: Text(document["titulo"]),
            leading: Text(document['hora']),
            subtitle: Text(sub),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NoteView(author: "",descripcion: descripcion,titulo: titulo,)));
            },
          )),
    );
  }
}

