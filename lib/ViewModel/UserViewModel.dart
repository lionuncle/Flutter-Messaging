import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messages/Model/User.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel{


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


    DocumentSnapshot documentSnapshot = userQuery.documents.first;
    User user = User();
    user.fromJson(documentSnapshot.data);
    return user;

  }

  User getCurrentUser() => User(id: "45kls-1dfeifd-45421cd-dfjeioj",name:"CURRENT USER");

  Future<List<User>> getAllUsers() async{
     List<User> list = List();
    QuerySnapshot userQuery = await db
        .getDocuments();
    for(DocumentSnapshot documentSnapshot in userQuery.documents){
      User user = User();
      user.fromJson(documentSnapshot.data);
      list.add(user);
    }
    return list;
  }

}
