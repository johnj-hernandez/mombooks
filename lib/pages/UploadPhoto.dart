import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  FirebaseStorage storage=FirebaseStorage.instance;
  String currentFileUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Picture",
          style:TextStyle(
            fontWeight: FontWeight.bold
          ) ,),
        centerTitle: true,
      ),
      body: builtBody(),
    );
  }

  Widget builtBody() {
    StorageReference storageRef = storage.ref();
    storageRef.child('profile/default-user.png').getDownloadURL();
    return Container(
      child: Column(
        children: <Widget>[
          Text(
           "Foto de perfil Actual:"
          ),
          Image.network("https://firebasestorage.googleapis.com/v0/b/mombook-9413a.appspot.com/o/profile%2Fdefault-user.png?alt=media&token=174ded42-23b6-4ef0-863f-2ced8045e03e")
        ],
      ),
    );
  }
}
