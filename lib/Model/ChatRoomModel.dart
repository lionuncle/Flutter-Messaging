import 'package:uuid/uuid.dart';

class ChatRoomModel {

  List<dynamic> userIds = List();
  String id;


  ChatRoomModel({String usersOneId,String userTwoId}){
    //if id is null then assign it to UniqueKey otherwise leave as it is
    this.id = id ??= Uuid().v1();
    this.userIds.add(usersOneId);
    this.userIds.add(userTwoId);
  }

  Map<String, dynamic> toJson() =>
      {
        'userIds': this.userIds,
      };

  fromJson(Map parsedJson) {
    this.userIds = parsedJson['userIds'] ?? '';

  }

}