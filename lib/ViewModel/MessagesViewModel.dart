import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MessagesViewModel{

  sendMsg(@required senderId, @required msg){
    CollectionReference db = Firestore.instance.collection('ChatRooms');

    CreateNewRoomBetween(String userOneId, String userTwoId)async{
      Firestore.instance.runTransaction((Transaction tx) async {
        //var _result = await db.add(ChatRoomModel(usersOneId: userOneId,userTwoId: userTwoId).toJson());

      });
    }
  }
}