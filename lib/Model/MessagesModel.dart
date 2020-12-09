import 'package:flutter/cupertino.dart';

class MessagesModel{

  //Map<senderId, msg>
  //Map<String, String> message = {};
  String message;
  String senderId;

  MessagesModel({@required String senderId,@required String msg}){
    this.message = msg;
    this.senderId = senderId;

  }

  Map<String, dynamic> toJson() =>
      {
        'message': this.message,
        'senderId': this.senderId,
      };
  fromJson(Map parsedJson) {
    this.message = parsedJson['message'] ?? '';
    this.senderId = parsedJson['senderId'] ?? '';
  }
}