import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messages/Model/MessagesModel.dart';
import 'package:flutter/cupertino.dart';

class MessagesViewModel{

  CollectionReference db = Firestore.instance.collection('Messages');
  sendMsg(@required MessagesModel message){
    Firestore.instance.runTransaction((Transaction tx) async {

      await db.add(message.toJson());

    });
  }

  Future<List<MessagesModel>> getAllMessagesOfRoom(@required String roomId) async{

    QuerySnapshot msgQuery = await db
        .where('roomId', isEqualTo: roomId)
        .getDocuments();

    List<MessagesModel> allMessages = List();
    for(DocumentSnapshot documentSnapshot in msgQuery.documents){
      MessagesModel msg = MessagesModel();
      msg.fromJson(documentSnapshot.data);
      allMessages.add(msg);
    }

    return allMessages;

  }


}