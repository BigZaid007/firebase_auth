

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Services/auth.dart';
import 'package:new_project/Services/auth_Provider.dart';
import 'package:new_project/loginScreens/landingPage.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Complete 1');
  await Firebase.initializeApp();
  print('Complete 2');

  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    print('checking');


    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: landingPage(auth: Auth(),),

      ),
    );
  }
}

