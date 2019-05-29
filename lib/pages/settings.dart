import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Settings extends StatefulWidget {
  const Settings({Key key, this.uid}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
  final String uid;
}

class _SettingsState extends State<Settings> {
  bool edicion=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:_CustomStreamBuilder(context) ,
    );
  }

  Widget _CustomStreamBuilder(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("users").where("uid",isEqualTo: this.widget.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          default:
            String nombre=snapshot.data.documents[0]["nombre"]==null?"Actualiza tu nombre":snapshot.data.documents[0]["nombre"].toString();
            String apellido=snapshot.data.documents[0]["apellido"]==null?"Actualiza tu apellido":snapshot.data.documents[0]["apellido"].toString();
            String edad=snapshot.data.documents[0]["edad"]==null?"Actualiza tu Edad":snapshot.data.documents[0]["edad"].toString();
            String newNombre=this.edicion?"":"";
            String newApellido=this.edicion?"":"";
            String newEdad=this.edicion?"":"";
            //apellido="dedede";
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 300),
                    child: MaterialButton(
                      onPressed: (){
                        setState(() {
                          this.edicion=!this.edicion;
                        });
                      },
                      child: Icon(Icons.edit,color: this.edicion?Colors.blue:Colors.grey,),
                    ),
                  ),
                  Text("Mi Informacion ",style: TextStyle(fontSize: 40),),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Nombre: ",style: TextStyle(fontSize: 20),),
                     !this.edicion?Text(nombre,style: TextStyle(fontSize: 20,)):
                     Flexible(
                       child: TextField(
                         
                         decoration: InputDecoration(
                             hintText: "Ingresa tu Nombre"
                         ),
                         onChanged: (value){
                           setState(() {
                             newNombre=value;
                           });
                         },
                       ),
                     ),//AQUI HAGO LA COMPROBACION ? TEXTO: INPUT TEXT
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Apellido: ",style: TextStyle(fontSize: 20),),
                      !this.edicion?Text(apellido,style: TextStyle(fontSize: 20),):
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Ingresa tu Apellido"
                          ),
                          onChanged: (value){
                            setState(() {
                              newApellido=value;
                            });
                          },
                        ),
                      ),//AQUI HAGO LA COMPROBACION ? TEXTO: INPUT TEXT
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Edad: ",style: TextStyle(fontSize: 20),),
                      !this.edicion?Text(edad,style: TextStyle(fontSize: 20),):
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Ingresa tu edad"
                          ),
                          onChanged: (value){
                            setState(() {
                              newEdad=value;
                            });
                          },
                        ),
                      ),//AQUI HAGO LA COMPROBACION ? TEXTO: INPUT TEXT
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: !this.edicion?Container():
                    RaisedButton(onPressed: (){
                      //getData(); AQUI ENVIO LOS DATOS QUE SE ENCUENTRAN AHORA MISMO EN LOS CAMPOS
                    },
                      child: Container(
                        child: Text("Enviar",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      splashColor: Colors.blue,
                      elevation: 10,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      textColor: Colors.blue,

                    ),
                  )
                ],
              ),


            );
        }
      },
    );
  }

}


