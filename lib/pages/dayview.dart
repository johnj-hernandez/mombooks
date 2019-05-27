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
    String userID=widget.user.uid;

    return Container();
  }
}
