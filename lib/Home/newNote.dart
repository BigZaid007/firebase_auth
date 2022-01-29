import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_project/Home/notesList.dart';
import 'package:new_project/Services/auth.dart';

import 'eventList.dart';

class newNote extends StatefulWidget {
  newNote({required this.auth});
  AuthBass auth;
  @override
  _newNoteState createState() => _newNoteState();
}

class _newNoteState extends State<newNote> {

  TextEditingController txtTitle= TextEditingController();
  TextEditingController txtDes= TextEditingController();

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      bottomNavigationBar:Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          onTap: (){


            addTasks(txtTitle.text, txtDes.text);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>notesList()));



          },
          child: BottomAppBar(
            elevation: 10,
            color: Colors.red,
            child: Container(width: 160,height: 65,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text('Save',style: TextStyle(
                  fontWeight: FontWeight.w700,color: Colors.black,fontFamily: 'Prata',fontSize: 28
              ),),),

          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontFamily: 'Prata',
            fontSize: 28,
            fontWeight: FontWeight.w700

        ),
        backgroundColor:Color(0xff070706),
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(height: 15,),
          //add event form
          Form(
            //key: _formKey,
            child: Column(
              children: [

                TextFormField(
                  controller: txtTitle,

                  decoration: InputDecoration(
                    hintText: "Title",
                    prefixIcon: Icon(FontAwesomeIcons.smile),
                    border: InputBorder.none,
                    //contentPadding: const EdgeInsets.only(left: 48.0),
                  ),
                ),
                Divider(),
                TextFormField(

                  controller: txtDes,

                  //initialValue: widget.event?.description,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Note",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.text_snippet)),
                ),

                Divider(),




                Divider(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}



Future addTasks (String title,String dec) async
{

  final String uid=FirebaseAuth.instance.currentUser.uid;

  final databaseReference = FirebaseFirestore.instance;
  databaseReference.collection('users').doc(uid).collection('notes').add({
    'title':title,
    'des':dec
  });
}