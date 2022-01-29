
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ndialog/ndialog.dart';
import 'package:new_project/Services/auth.dart';
import 'package:new_project/UI/welcome.dart';
import 'package:new_project/loginScreens/signInPage.dart';


class signInEmail extends StatefulWidget {
  signInEmail({required this.auth});
  final AuthBass auth;
  @override
  _signInEmailState createState() => _signInEmailState();
}

int blue = 0xff5d9ad8;
int text = 0xff034F84;
bool _isObscure = true;

class _signInEmailState extends State<signInEmail> {
  @override
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

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
                 welcomeScreen(''),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Prata',
                              color: Color(text)),
                        ),
                        SizedBox(
                          height: 10,
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
                                hintText: 'Enter Your Email',
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
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  'Forget Password?',
                                  style: TextStyle(color: Color(text)),
                                ),
                              )),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {

                            try {
                              await widget.auth.signInWithEmail(_email.text, _password.text);
                              setState(() {

                              });
                              Navigator.pop(context);
                            } catch (e) {
                              await DialogBackground(
                                  dialog: AlertDialog(
                                    elevation: 8,

                                      title: Text("Warning",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600),),
                                      content:Text("Incorrect Email or Password"),
                                      actions: <Widget>[
                                    FlatButton(child: Text("Retry") ,onPressed: () {
                                      Navigator.pop(context);
                                    }),
                                   FlatButton(child: Text("Cancel"),onPressed: () {
                                     Navigator.pop(context);
                                   }),

                            ],
                            ),
                            ).show(context);

                          }

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
                                'Login',
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
                              Text(''' Don't have an account? '''),
                              SizedBox(
                                width: 1.2,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => signInPage(auth: widget.auth,)));
                                },
                                child: Text(
                                  'Sign up',
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

