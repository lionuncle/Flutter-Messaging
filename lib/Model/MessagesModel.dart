import 'package:flutter/cupertino.dart';

class MessagesModel{


  String message;
  String senderId;
  String roomId;

  MessagesModel({@required String senderId,@required String msg,@required String roomId}){
    this.message = msg;
    this.senderId = senderId;
    this.roomId = roomId;

  }

  Map<String, dynamic> toJson() =>
      {
        'message': this.message,
        'senderId': this.senderId,
        'roomId': this.roomId
      };
  fromJson(Map parsedJson) {
    this.message = parsedJson['message'] ?? '';
    this.senderId = parsedJson['senderId'] ?? '';
    this.roomId = parsedJson['roomId'] ?? '';
  }
}