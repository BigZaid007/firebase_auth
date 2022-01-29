import 'package:cloud_firestore/cloud_firestore.dart';



class createUser
{

  final String uid;
  createUser({required this.uid});

  CollectionReference user=FirebaseFirestore.instance.collection('users');

  Future updateUser(String email) async
  {
    await user.doc(uid).set(
      {
        'uid':uid,
        'email':email
      }
    );
  }
}
