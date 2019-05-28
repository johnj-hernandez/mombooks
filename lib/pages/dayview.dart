import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    String userID=this.widget.user.uid;

    return Container(
      margin: EdgeInsets.all(20),
      child: StreamBuilder<QuerySnapshot>(
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
      ),
    );
  }

  Widget _buildRow(BuildContext context, DocumentSnapshot document) {
    return Material(
      child: Container(
        
          margin:EdgeInsets.all(10),
          height: 40.0,
          child: ListTile(
            title: Text(document["titulo"]),
            leading: Text(document['hora']),
            //Falta agregarle el ontap que llevara a toda la informacion de la nota
          )),
    );
  }
}

