import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:mombook/note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {

  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Book"),
      ),
      body: CalendarHome(user: this.user,),
    );
  }
}

class CalendarHome extends StatefulWidget {
  const CalendarHome({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _CalendarHomeState createState() => _CalendarHomeState();
}

class _CalendarHomeState extends State<CalendarHome> {
  List<DateTime> mylist = new List();

  @override
  Widget build(BuildContext context) {

    //mylist.add(DateTime(2019,5,20));
    //mylist.add(DateTime(2019,5,21));
    //agregamos una nota de prueba desde aqui
    String userID=widget.user.uid;
    ///Firestore.instance.collection("notes").document(userID).setData({
    ///  'hora':'7:30',
     /// 'descripcion':'aqui esta mi primera nota',
     /// 'titulo':'primera nota',
     /// 'fecha':'2019-05-14'
   /// });
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("notes").where("uid",isEqualTo: userID).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          default:
            int nDates=snapshot.data.documents.length;
            List<DateTime> mylist = new List();
            if(nDates>0){
              for(var doc in snapshot.data.documents){
                String fecha=doc['fecha'];
                mylist.add(DateTime.parse(fecha));
              }
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: CalendarCarousel(
                thisMonthDayBorderColor: Colors.grey,
                height: 520.0,
                todayButtonColor: Colors.blue,
                todayBorderColor: Colors.blue,
                markedDates: mylist ,
                markedDateShowIcon: true,
                markedDateMoreCustomTextStyle: TextStyle(backgroundColor: Colors.teal,color: Colors.amber),
                //selectedDateTime: _currentDate,
                daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
//          weekendStyle: TextStyle(
//            color: Colors.red,
//          ),
//          weekDays: null, /// for pass null when you do not want to render weekDays
                //      headerText: Container( /// Example for rendering custom header
                //          child: Text('Custom Header'),
//          ),
              ),
            );
        }
      },
    );




  }
}

