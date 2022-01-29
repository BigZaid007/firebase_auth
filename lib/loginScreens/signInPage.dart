import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_project/Home/getStarted.dart';
import 'package:new_project/Services/auth.dart';
import 'package:new_project/UI/welcome.dart';
import 'package:new_project/loginScreens/EmailSignUp.dart';

import 'package:new_project/loginScreens/signInEmail.dart';


class signInPage extends StatelessWidget {

  const signInPage({Key? key, required this.auth}) : super(key: key);
  final AuthBass auth;

  @override

  Widget build(BuildContext context) {
    int blue = 0xff5d9ad8;
    int text = 0xff034F84;





    //SignIn with Google method
    Future<void> signInWithGoogle() async
    {
      try{
        await auth.signInWithGoogle();
      }
      catch(e)
      {
        print(e.toString());
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffd5d0e5),
                    Color(0xffb8c6db),
                  ])),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [

                // Image(
                //   image: AssetImage('assets/fox.png'),
                //   width: 150,
                //   height: 150,
                // ),
                SizedBox(height: 100,),
                welcomeScreen('Welcome To'),
                Column(
                    children: [
                      Text(
                        'Signing In ',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Prata',
                            color: Color(text)),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        ''' It's much easier now ''',
                        style: TextStyle(fontSize: 14, color: Color(text)),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      InkWell(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>signInEmail(auth: auth,)));
                        },
                        child: Container(
                          width: 320,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(15.0),
                            color: Colors.indigo,
                          ),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Sign In using Email',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      InkWell(
                        onTap: ()
                        {
                          //TODO sign in with google
                          signInWithGoogle();
                        },
                        child: Container(
                          width: 320,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(10.0),
                            color: Colors.red,
                          ),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Sign In using Google',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                     
                      SizedBox(height: 20,),




                      SizedBox(
                        height: 35,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '''Don't have an account?''',
                              style: TextStyle(
                                  fontFamily: 'Prata',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailSignUp(auth: auth)));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontFamily: 'Prata',
                                  color: Color(text),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      )


                    ]
                ),




              ],
            ),
          ),



        ),
      ),
    );
  }
}
