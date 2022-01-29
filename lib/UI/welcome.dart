import 'package:flutter/material.dart';

class welcomeScreen extends StatelessWidget {
  welcomeScreen(this.txt);
  final String txt;

  int blue = 0xff5d9ad8;
  int text = 0xff034F84;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          txt,
          style: TextStyle(
              fontFamily: 'Prata', fontSize: 30, color: Color(blue),fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 30,),
        Text(
          'NOTEX',
          style: TextStyle(
              fontFamily: 'Lobster', fontSize: 55, color: Colors.black,letterSpacing: 2),
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
