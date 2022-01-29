import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:new_project/Home/task.dart';
import 'package:new_project/Services/auth.dart';

import 'package:new_project/loginScreens/landingPage.dart';

import 'dart:ui';



import 'newNote.dart';


class eventList extends StatefulWidget {
  eventList({required this.Auth});
  AuthBass Auth;
  @override
  _eventListState createState() => _eventListState();
}

class _eventListState extends State<eventList> {


  @override

  final String uid=FirebaseAuth.instance.currentUser.uid;
  CollectionReference users=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('notes');
  final query  = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid). collection('notes').doc(FirebaseAuth.instance.currentUser.uid).get();


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(

          child: Icon(
            FontAwesomeIcons.pencilAlt,color: Color(0xff070706),
          ),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>newNote(auth:Auth())));
          },
          backgroundColor: Colors.white,
        ),

        //backgroundColor: Color(0xff070706),

        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>landingPage(auth: Auth(),)));
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          ],
          elevation: 0.1,
          //backgroundColor: Color(0xff070706),
          title: Text('Notes',style: TextStyle(
            fontSize: 25,fontFamily: 'Prata',fontWeight: FontWeight.w700
          ),),centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children:[
              StreamBuilder(
              stream:FirebaseFirestore.instance.collection('users/$uid/notes/$uid').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot)
              {
                if(snapshot.hasError)
                  return Text('Something went wrong',style: TextStyle(
                    color: Colors.white
                  ),);

                // if(snapshot.requireData.docs.isEmpty) {
                //   return Container(
                //     alignment: AlignmentDirectional.center,
                //     height: 500,
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.center,
                //
                //       children: [
                //         Icon(FontAwesomeIcons.plusCircle,color: Colors.white,),
                //         SizedBox(width: 8,),
                //         Text('Add Your First Note',style: TextStyle(
                //           color: Colors.white
                //         ),)
                //       ],
                //     ),
                //   );
                // }

                if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }

                final date=snapshot.requireData;


                //Color cardRandom=Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

                // return  Center(
                //   child: ListView(
                //     children: snapshot.data!.docs.map((DocumentSnapshot document) {
                //       Map<String, dynamic> data = document.data()!;
                //       return ListTile(
                //         //tileColor: Colors.white,
                //         title: Text(data['title']),
                //         // subtitle: Text(data['des']),
                //       );
                //     }).toList(),
                //   ),
                // );
                return Expanded(
                  child: GridView.builder(

                      itemCount: date.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {

                        String title=date.docs[index]['title'];
                        String des=date.docs[index]['description'];
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: InkWell(
                            onTap: (){
                             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>task(title,des,DateTime.now())));
                            },
                            child: new Card(

                              elevation: 0.8,
                              //color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                color: _colors[index],
                              child: new GridTile(
                                footer: Padding(
                                  padding: const EdgeInsets.only(bottom: 8,left: 2),
                                  child: Text('what}',style: TextStyle(
                                    fontSize: 13,color: Colors.grey[800],fontWeight: FontWeight.w600
                                  ),),
                                ), child: Text(''),


                              ),
                            ),
                          ),
                        );
                      },
                    ),
                );
                // );(
                //   child: Text(date.docs),
                //   shrinkWrap: true,
                //   itemCount: date.size,
                //   itemBuilder: (context,index)
                //   {
                //     String title=date.docs['title'];
                //     String des=date.docs[index]['description'];
                //
                //     Timestamp timestamp=date.docs[index]['date'];
                //     DateTime dateTime=timestamp.toDate();
                //     final format=DateFormat('EEEE, dd MMMM, yyyy');
                //     return Card(
                //       elevation: 8.0,
                //       margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                //       child: Container(
                //         decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                //         child: ListTile(
                //             contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                //             leading: Container(
                //               padding: EdgeInsets.only(right: 12.0),
                //               decoration: new BoxDecoration(
                //                   border: new Border(
                //                       right: new BorderSide(width: 1.0, color: Colors.white24))),
                //               child: Icon(Icons.star,color: Colors.white,size: 30,),
                //             ),
                //             title: Text('${date.docs[index]['title']}',style: TextStyle(
                //                 fontWeight: FontWeight.w700,fontSize: 30,color: Colors.white),),
                //             // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                //
                //             subtitle: Padding(
                //               padding: const EdgeInsets.only(top: 8),
                //               child: Row(
                //                 children: <Widget>[
                //                   //Icon(Icons.linear_scale, color: Colors.yellowAccent),
                //                   Text('${format.format(dateTime)}',style: TextStyle(
                //                       color: Colors.white
                //                   ),),
                //                 ],
                //               ),
                //             ),
                //             trailing:
                //             IconButton(onPressed:(){
                //
                //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>task(title,des,dateTime)));
                //
                //
                //             },icon:Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0))),
                //
                //
                //
                //       ),);
                //
                //   },
                //
                // );

              },

            ),
          ]),
        ),

      ),
    );
  }

}


Future getNotes() async
{
  final user  = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid). collection('notes').doc(FirebaseAuth.instance.currentUser.uid).get();
}

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
