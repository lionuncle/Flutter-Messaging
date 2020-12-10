import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messages/Model/ChatRoomModel.dart';
import 'package:firebase_messages/ViewModel/UserViewModel.dart';
import 'package:firebase_messages/Widgets/Widgets.dart';

class ChatRoomViewModel{

  static ChatRoomModel _existingChatRoom;
  CollectionReference db = Firestore.instance.collection('ChatRooms');

  Future<bool> CreateNewRoomBetween(String userOneId, String userTwoId)async{
    bool isExisting = await _isRoomAlreadyExisting(userOneId, userTwoId);
    // bool isExisting = false;
    if(isExisting){
      ApplicationToast.getInfoToast(durationTime: 3, heading: "null", msg: "Chat room already existing");
      return false;
    }
    await Firestore.instance.runTransaction((Transaction tx) async {
      ChatRoomModel chatRoom = ChatRoomModel(usersOneId: userOneId,userTwoId: userTwoId);
      await db.document(chatRoom.id).setData(chatRoom.toJson()).whenComplete(() {

      });
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

    }).catchError((error){
      print("Error while checking duplicate chat rooms : "+ error);
      return isExisting;
    });
    return isExisting;
  }
  Future<List<ChatRoomModel>> getAllChatRoomsOfCurrentUser() async{
    List<ChatRoomModel> list = List();
    QuerySnapshot query = await db.getDocuments();
    for(DocumentSnapshot documentSnapshot in query.documents){
      ChatRoomModel chatRoom = ChatRoomModel();
      chatRoom.fromJson(documentSnapshot.data);
      if (chatRoom.userIds[0] == UserViewModel().getCurrentUser().id) {
        ChatRoomModel chatRoom = ChatRoomModel();
        chatRoom.fromJson(documentSnapshot.data);
        list.add(chatRoom);
      }
    }
    return list;
  }
}