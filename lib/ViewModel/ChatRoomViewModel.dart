import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messages/Model/ChatRoomModel.dart';
import 'package:firebase_messages/View/ChatRoom.dart';

class ChatRoomViewModel{

  static ChatRoomModel _existingChatRoom;
  CollectionReference db = Firestore.instance.collection('ChatRooms');

  Future<bool> CreateNewRoomBetween(String userOneId, String userTwoId)async{
    bool isExisting = await _isRoomAlreadyExisting(userOneId, userTwoId);
    if(isExisting){
      return false;
    }
    Firestore.instance.runTransaction((Transaction tx) async {
      ChatRoomModel chatRoom = ChatRoomModel(usersOneId: userOneId,userTwoId: userTwoId);
      await db.document(chatRoom.id).setData(chatRoom.toJson());
    });
    return true;
  }

  Future<bool> _isRoomAlreadyExisting(String userOneId, String userTwoId) async {
    bool isExisting = false;
    QuerySnapshot documents = await db.getDocuments();
    await Firestore.instance.runTransaction((transaction) async {
      for(DocumentSnapshot element in documents.documents){
        ChatRoomModel chatRoom = ChatRoomModel();
        chatRoom.fromJson(element.data);
        if(chatRoom.userIds.contains(userOneId) && chatRoom.userIds.contains(userTwoId)){
          _existingChatRoom = chatRoom;
          isExisting =  true;
          break;
        }
      }
    });
    return isExisting;
  }
}