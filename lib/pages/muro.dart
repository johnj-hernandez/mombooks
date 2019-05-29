import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mombooks/pages/noteView.dart';

class Muro extends StatefulWidget {
  @override
  _MuroState createState() => _MuroState();
}

class _MuroState extends State<Muro> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4,left: 2,right: 2),
      child: _CustomStreamBuilder(context),
    );
  }

  Widget _CustomStreamBuilder(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("notes").where("public",isEqualTo: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          default:
            return ListView.builder(
              itemCount: snapshot.data.documents.length-1,
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
    return Material(
      child: Container(
          margin:EdgeInsets.all(10),
          height: 60.0,
          child: ListTile(
            title: Text(document["titulo"]),
            //leading: Text(document['hora']),
            subtitle: Text(sub),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NoteView(author: "",descripcion:document['descripcion'].toString() ,titulo: document["titulo"],)));
            },
          )),
    );
  }
}
