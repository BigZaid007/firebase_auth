import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Services/auth.dart';


class getStarted extends StatefulWidget {

  const getStarted({Key? key, required this.auth}) : super(key: key);


  final AuthBass auth;

  @override
  _getStartedState createState() => _getStartedState();
}

class _getStartedState extends State<getStarted> {


  Future<void> signOut() async
  {
    await widget.auth.signOut();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 200,),
          Center(
              child: TextButton(
                onPressed: () async {
                  await widget.auth.signOut();
                  Navigator.of(context).pop();

                  print('Print');

                },
                child: Text('Create ID'),
              )

          ),



        ],


      ),
    );
  }
}


