import 'package:firebase_messages/Model/MessagesModel.dart';
import 'package:firebase_messages/Model/User.dart';
import 'package:firebase_messages/Utilities/AppSizes.dart';
import 'package:firebase_messages/Widgets/Widgets.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  User host = User(id: "id",name: "Aqib");
  User otherUser = User(id: "fjsdklfjkl",name: "Other");
  MessagesModel message = MessagesModel(senderId: "fjsdklfjkl",msg: "Hello brother, How are you?");
  MessagesModel message2 = MessagesModel(senderId: "id",msg: "Hello brother");
  MessagesModel message3 = MessagesModel(senderId: "fjsdklfjkl",msg: "Hello brother");
  List<MessagesModel> messageList = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("USER0"),),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(height: AppSizes.height * .8,
            color: Colors.grey[200],
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Container(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index){
                  messageList.add(message);
                  messageList.add(message2);
                  messageList.add(message3);
                  if(messageList.elementAt(index).senderId == host.id){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40.0),
                                bottomRight: const Radius.circular(40.0),
                                bottomLeft: const Radius.circular(40.0),

                              )
                          ),
                          //color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(messageList.elementAt(index).message),
                          ),
                        ),
                      ),
                    );
                  }
                  else{// if (messageList.elementAt(index).senderId == otherUser.id){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.green,
                              borderRadius: new BorderRadius.only(
                                topRight: const Radius.circular(40.0),
                                bottomRight: const Radius.circular(40.0),
                                bottomLeft: const Radius.circular(40.0),

                              )
                          ),
                          //color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(messageList.elementAt(index).message,style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            ),


            Container(height: AppSizes.height * .1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                      width:AppSizes.width * .7,
                      child: TextFormField( decoration: InputDecoration(hintText: "Start typing message..."),)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: FloatingActionButton(
                        onPressed: (){
                          ApplicationToast.getSuccessToast(msg: "message sent");
                        },
                        child: Icon(Icons.send),
                      ),
                    ),
                  ),
                )
              ],
            ),
            ),

          ],
        ),
      ),
    );
  }
}
