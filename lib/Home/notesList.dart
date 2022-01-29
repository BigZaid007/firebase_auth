import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_project/Home/getStarted.dart';
import 'package:new_project/Home/newNote.dart';
import 'package:new_project/Home/task.dart';
import 'package:new_project/Services/auth.dart';

class notesList extends StatefulWidget {
  @override
  _notesListState createState() => _notesListState();
}

class _notesListState extends State<notesList> {

  final String uid=FirebaseAuth.instance.currentUser.uid;
  List<Color> _colors=[
    Color(0xffFFFF66),
    Color(0xffFF6F61),
    Color(0xffcbdb57),
    Color(0xfff96a4b),
    Color(0xfffe9a37),
    Color(0xff9585ba),
    Color(0xff6F9FD8),
    Color(0xffFFFF66),
    Color(0xff3F69AA),
    Color(0xffFF6F61),
    Color(0xffcbdb57),
    Color(0xfff96a4b),
    Color(0xfffe9a37),
    Color(0xff9585ba),
    Color(0xff6F9FD8),
    Color(0xffFFFF66),
    Color(0xff3F69AA),
    Color(0xffFF6F61),
    Color(0xffcbdb57),
    Color(0xfff96a4b),
    Color(0xfffe9a37),
    Color(0xff9585ba),
    Color(0xff6F9FD8),
    Color(0xffFFFF66),
    Color(0xff9585ba),
    Color(0xff6F9FD8),
    Color(0xffFFFF66),
    Color(0xff3F69AA),
    Color(0xffFF6F61),
    Color(0xffcbdb57),
    Color(0xfff96a4b),
    Color(0xfffe9a37),


  ];
  //final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').doc(uid).collection('notes').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff070706),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>getStarted(auth: Auth(),)));
          }, icon: Icon(Icons.account_box))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(uid).collection('notes').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                final int index=snapshot.data!.docs.length;



                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,

                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                      return InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>task(data['title'])));
                        },
                        child: Card(
                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          child:Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 8),
                            child: Text(data['title'],style: TextStyle(
                                fontWeight: FontWeight.w500,color: Colors.white,fontSize: 22
                            ),),
                          ) ,


                          //subtitle: Text(data['company']),
                        ),
                      );


                    }).toList(),


                  ),
                );

              },

            ),

          ],
        ),
      )
      ,floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(

          // Cannot be `Alignment.center`
          alignment: Alignment.bottomRight,
          ringColor:  Colors.transparent,
          ringDiameter: 500.0,
          ringWidth: 200.0,
          fabSize: 64.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),
          fabColor: Colors.white,
          fabOpenIcon: Icon(FontAwesomeIcons.pencilAlt, color: Colors.black),
          fabCloseIcon: Icon(Icons.close, color: Colors.black),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) {
            _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
          },
          children: <Widget>[

            ElevatedButton.icon(
              style:ElevatedButton.styleFrom(
            primary: Colors.transparent),
              icon: Icon(FontAwesomeIcons.list),
              label: Text('Todo List'),
              onPressed: () {},
            ),
            ElevatedButton.icon(
              style:ElevatedButton.styleFrom(
                  primary: Colors.transparent),
              icon: Icon(FontAwesomeIcons.paragraph),
              label: Text('Long Note'),
              onPressed: () {},
            ),
            ElevatedButton.icon(
              style:ElevatedButton.styleFrom(
                  primary: Colors.transparent),
              icon: Icon(FontAwesomeIcons.stickyNote),
              label: Text('Basic Note'),
              onPressed: () {},
            ),

          ],
        ),
      ),


      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     FontAwesomeIcons.pencilAlt,color: Color(0xff070706),
      //   ),
      //   onPressed: (){
      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>newNote(auth:Auth())));
      //   },
      //   backgroundColor: Colors.white,
      // ),

    );

  }
}


  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 1000),
        )
    );
  }

