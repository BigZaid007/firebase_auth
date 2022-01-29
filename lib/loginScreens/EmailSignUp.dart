import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Home/CalenderPage.dart';
import 'package:new_project/UI/welcome.dart';
import 'signInPage.dart';
import 'package:new_project/Services/auth.dart';

import 'package:new_project/loginScreens/signInEmail.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailSignUp extends StatefulWidget {
  EmailSignUp({required this.auth});
  final AuthBass auth;
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

int blue = 0xff5d9ad8;
int text = 0xff034F84;
bool _isObscure = true;

class _EmailSignUpState extends State<EmailSignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfig = TextEditingController();

  late String email, password, passwordConfig;

  final formKey = GlobalKey<FormState>();
  bool autoSaved = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
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
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  SizedBox(height: 100,),
                 welcomeScreen('Register To'),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Creating Your Account',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Prata',
                              color: Color(text)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 20),
                          child: TextFormField(
                            controller: _email,
                            // ignore: deprecated_member_use
                            autovalidate: autoSaved,
                            validator: (textValue) {
                              if (textValue!.trim().isEmpty)
                                return 'This Field Cannot be Empty';

                              String p =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                              RegExp regExp = new RegExp(p);

                              if (!regExp.hasMatch(textValue)) {
                                return 'The Email is Valid';
                              }

                              return null;
                            },
                            onChanged: (textValue) {
                              setState(() {
                                email = textValue;
                              });
                            },

                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  FontAwesomeIcons.userCircle,
                                  color: Color(text),
                                ),
                                hintText: 'Enter Your Email/Username',
                                filled: true,
                                fillColor: Colors.white60,
                                hintStyle: TextStyle(color: Color(text)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 20),
                          child: TextFormField(
                            controller: _password,
                            validator: (textValue) {
                              if (textValue!.length <= 7)
                                return 'Password must be 8 chars';
                            },
                            onChanged: (textValue) {
                              setState(() {
                                password = textValue;
                              });
                            },
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  FontAwesomeIcons.lock,
                                  color: Color(text),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                hintText: 'Enter Your Password',
                                filled: true,
                                fillColor: Colors.white60,
                                hintStyle: TextStyle(color: Color(text)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 20),
                          child: TextFormField(
                            controller: _passwordConfig,
                            validator: (textValue) {
                              if (textValue!.trim().isEmpty)
                                return 'This Field Cannot be Empty';

                              if (textValue != password)
                                return 'The Password is no match';
                            },
                            onChanged: (textValue) {
                              setState(() {
                                passwordConfig = textValue;
                              });
                            },
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  FontAwesomeIcons.lock,
                                  color: Color(text),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                hintText: 'Re-Enter Your Password',
                                filled: true,
                                fillColor: Colors.white60,
                                hintStyle: TextStyle(color: Color(text)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              autoSaved = true;
                            });

                           try{
                             await widget.auth.CreateUserWithEmail(_email.text, _password.text);
                             Navigator.pop(context);
                           } catch(e){
                             showDialog(
                                 context: context,
                                 builder: (context) {
                                   return AlertDialog(
                                     backgroundColor: Colors.white,
                                     elevation: 5.0,
                                     title: Center(
                                       child: Text(
                                         'Existed Account !',
                                         style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                                       ),
                                     ),
                                     content: Text('This Email is Already used , Retry With Another Email Or Login if You Already Have An Account '),
                                     actions: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
                                           InkWell(
                                             onTap: () {
                                               Navigator.pop(context);
                                             },
                                             child: Container(
                                                 alignment: AlignmentDirectional.center,
                                                 padding: EdgeInsets.symmetric(horizontal: 20),
                                                 decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(20),
                                                     color: Colors.red),
                                                 width: 100,
                                                 height: 50,
                                                 child: Text(
                                                   'Retry',
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 18,
                                                       fontWeight: FontWeight.w700),
                                                 )),
                                           ),
                                           InkWell(
                                             onTap: () {
                                               Navigator.push(
                                                   context,
                                                   MaterialPageRoute(
                                                       builder: (context) => signInEmail(auth: widget.auth)));
                                             },
                                             child: Container(
                                                 alignment: AlignmentDirectional.center,
                                                 padding: EdgeInsets.symmetric(horizontal: 20),
                                                 decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(20),
                                                     color: Colors.blue),
                                                 width: 100,
                                                 height: 50,
                                                 child: Text(
                                                   'Login',
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 18,
                                                       fontWeight: FontWeight.w700),
                                                 )),
                                           ),
                                         ],
                                       )
                                     ],
                                   );
                                 });
                           }



                            final form = formKey.currentState;
                            if (form!.validate())
                              return null;
                            else
                              form.save();
                          },
                          child: Container(
                            width: 180,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(text),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontFamily: 'Prata',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(''' Already have an account? '''),
                              SizedBox(
                                width: 1.2,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => signInPage(auth: widget.auth)));
                                },
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                      color: Color(text),
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
