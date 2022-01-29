import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



abstract class AuthBass
{
  User get currentUser;
  Stream<User> onStateChange();
  Future<User> signInAnonymously ();
  Future<User> signInWithGoogle();
  Future<User> CreateUserWithEmail(String email,String password);
  Future<User> signInWithEmail(String email,String password);
  Future<void> signOut();
}


class Auth implements AuthBass
{
  final _auth=FirebaseAuth.instance;

  @override
  Stream<User> onStateChange() => _auth.authStateChanges();


  //method for getting the current user
  @override
   User get currentUser => _auth.currentUser;


   //method for sign in Anonymously that return the user
  @override
  Future<User> signInAnonymously () async
  {
    final userCredential=await _auth.signInAnonymously();
    return userCredential.user;
  }



  //signIn with Email and password
  @override
  Future<User> signInWithEmail(String email,String password) async
  {
    final userCredential=await _auth.signInWithCredential(
      EmailAuthProvider.credential(email:email,password: password)
    );
    return userCredential.user;
  }

  //signUpWithEmail
  @override
  Future<User> CreateUserWithEmail(String email,String password) async
  {
    final userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    CollectionReference users=FirebaseFirestore.instance.collection('users');
    users.doc(_auth.currentUser.uid).set({
      'email':_auth.currentUser.email,
      'id':_auth.currentUser.uid
    });
    return userCredential.user;
  }


  //sign in with google
  @override
  Future<User> signInWithGoogle() async
  {
    final google=GoogleSignIn();

    final googleUser= await google.signIn();

    if(googleUser != null)
      {
        final googleAuth= await googleUser.authentication;

        if(googleAuth.idToken != null)
          {
            final userCredential = await _auth.signInWithCredential(GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken
            ));

            return userCredential.user;

          }
      }
    throw FirebaseAuthException(message: 'message', code: '');

  }



  //method for sign out for the user

  @override
  Future<void> signOut() async
  {
    final google=GoogleSignIn();
    await google.signOut();
    await _auth.signOut();

  }



}