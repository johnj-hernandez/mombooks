
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Note extends StatefulWidget {
  final String title = "No title";
  //si quiero que le pasen el titulo creo el cosntructor aqui
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  //Se esta trabajando con archivoooos
  //ver comos e va a obtener la informacion de fireBASE
  Future<File> imageFile;

  //este metodo va a usar el pickImage y se le pasara solo la fuente del archivo
  //galeria para este caso y cambiara el estado enseguida
  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

//metodo para mostrar imagen si la hay, sino los respectivos mensajes

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        //actions: <Widget>[], agregar las acciones que se tendran en el appbar, como cambiar imagen, agregar
        //agregar si se tiene una Arreglo de imagenes
        //editar Texto
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showImage(),
            RaisedButton(
              child: Text("Select Image from Gallery"),
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
