import 'package:flutter/material.dart';


class NoteView extends StatefulWidget {
  const NoteView({Key key, this.author,this.titulo,this.descripcion}) : super(key: key);
  final String author;
  final String titulo;
  final String descripcion;
  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nota")
        ,),
      body: Container(
        child: ListView(
          children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                        this.widget.titulo,
                      style: TextStyle(
                        fontSize: 40
                      ),
                    ),
                  ),
                ),
            Center(child: Text(this.widget.author,style: TextStyle(color: Colors.grey),)),
            Container(
              margin: EdgeInsets.only(left: 10,top: 20,right: 10),
              child: Text(
                  this.widget.descripcion,
                style: TextStyle(fontSize: 17 ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
