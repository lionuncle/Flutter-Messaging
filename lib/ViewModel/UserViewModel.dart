import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messages/Model/User.dart';

class UserViewModel {


  CollectionReference db = Firestore.instance.collection('Users');

   addUser(User user )async{
    Firestore.instance.runTransaction((Transaction tx) async {
      var _result = await db.add(user.toJson());

    });
  }

  Future<User> getUserWithId(String uid) async{
    QuerySnapshot userQuery = await db
        .where('id', isEqualTo: uid)
        .getDocuments();
    DocumentSnapshot documentSnapshot = userQuery.documents[0];
    return User().fromJson(documentSnapshot.data);
  }

}
