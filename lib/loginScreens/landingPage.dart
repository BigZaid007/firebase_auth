
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Home/eventList.dart';
import 'package:new_project/Home/getStarted.dart';
import 'package:new_project/Home/notesList.dart';
import 'signInPage.dart';
import 'package:new_project/Services/auth.dart';


class landingPage extends StatelessWidget {
  const landingPage({Key? key, required this.auth}) : super(key: key);
  final AuthBass auth;


  @override
  Widget build(BuildContext context) {

      return StreamBuilder<User>(
          stream: auth.onStateChange(),
          builder: (context,snapshot)
      {
        final user=snapshot.data;
        if(snapshot.connectionState==ConnectionState.active)
          {
            if(user == null)
              //if there is no user we navigate to the signIn page to sign in
              return signInPage(auth: auth);
            else
              //if there is a user we will navigate to the add task page
              return notesList();
          }
        if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        else
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );

      });

  }
}
