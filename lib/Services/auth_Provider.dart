import 'package:flutter/material.dart';
import 'package:new_project/Services/auth.dart';



class AuthProvider extends InheritedWidget
{
  AuthProvider({required this.auth,required this.child}) : super(child: child) ;
  final AuthBass auth;
  final Widget child;


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false ;

  static AuthBass of(BuildContext context)
  {
    AuthProvider? provider= context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider!.auth;
  }


}