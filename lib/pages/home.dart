import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:mombooks/note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mombooks/pages/dayview.dart';

class Home extends StatelessWidget {

  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    double _iconSize=20.0;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 2.0,
              bottom: TabBar(
                labelColor: Colors.purpleAccent,
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.calendar_today,size: _iconSize)),
                  Tab(icon: Icon(Icons.assignment,size: _iconSize)),
                  Tab(icon: Icon(Icons.settings,size: _iconSize))
                ],
              ),

            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(4.0),
            child: TabBarView(
              children: <Widget>[
                CalendarHome(user: this.user,),
                Center(child: Icon(Icons.assignment)),
                Center(child: Icon(Icons.settings)),
              ],
            ),
          ),
        ),
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
                onDayPressed: (dateT,list){
                  //comprobamos que el mes tenga dos digitos
                  String month=dateT.month<10?"0"+dateT.month.toString():dateT.month.toString();
                  String fecha=(dateT.year).toString()+"-"+month+"-"+(dateT.day).toString();
                  print(fecha);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DayView(user: this.widget.user,fecha: fecha)));
                },
                daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
              ),
            );
        }
      },
    );




  }
}

