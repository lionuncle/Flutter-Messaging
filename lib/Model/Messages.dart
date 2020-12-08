import 'package:flutter/cupertino.dart';

class Messages{

  //Map<senderId, msg>
  Map<String, String> message = {};

  Messages({@required String senderId,@required String msg}){
    message = {senderId:msg};
  }

  Map<String, dynamic> toJson() =>
      {
        'message': this.message,
      };
  fromJson(Map parsedJson) {
    this.message = parsedJson['message'] ?? '';
  }
}