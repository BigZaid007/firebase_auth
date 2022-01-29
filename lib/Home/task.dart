
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:new_project/Home/notesList.dart';


class task extends StatefulWidget {
  String title;
  task(this.title);
  @override
  _taskState createState() => _taskState();
}

class _taskState extends State<task>  {
  DateTime _dateTime = DateTime.now();
  final format = DateFormat('EEEE, dd MMMM, yyyy');

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

          appBar: AppBar(
            backgroundColor: Color(0xff070706),
            elevation: 0.2,
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => notesList()));
              },
              icon: Icon(Icons.arrow_back),
            ),
            actions: [
              PopupMenuButton(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 0,
                      child: ListTile(
                        title: Text(
                          'Edit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        leading: Icon(
                          FontAwesomeIcons.edit,
                          color: Colors.white,
                        ),
                      )),
                  PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      title: Text(
                        'Delete',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      leading: Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      title: Text(
                        'Add To Favorite',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      leading: Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      title: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      leading: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                icon: Icon(Icons.menu),
                color: Colors.black,
              )
            ],
          ),
          backgroundColor: Color(0xff070706),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        format.format(_dateTime),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Text(
                    //   widget.des,
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       color: Colors.white,
                    //       fontStyle: FontStyle.italic),
                    // ),
                    Text(
                      'This is where the description will be ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
                
              ],
            ),
          ),



      ),
    );
  }
}

void onSelected(BuildContext context, item) {
  switch (item) {
    case 0:
      print('edit');
      break;
    case 1:
      print('delete');
  }
}

// await Firestore.instance.runTransaction((Transaction myTransaction) async {
// await myTransaction.delete(snapshot.data.documents[index].reference);
// });
