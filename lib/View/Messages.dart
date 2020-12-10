import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messages/Model/ChatRoomModel.dart';
import 'package:firebase_messages/Model/MessagesModel.dart';
import 'package:firebase_messages/Model/User.dart';
import 'package:firebase_messages/Utilities/AppSizes.dart';
import 'package:firebase_messages/ViewModel/MessagesViewModel.dart';
import 'package:firebase_messages/ViewModel/UserViewModel.dart';
import 'package:firebase_messages/Widgets/Widgets.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  ChatRoomModel currentChatRoom;

  Messages({@required this.currentChatRoom});

  @override
  _MessagesState createState() =>
      _MessagesState(currentChatRoom: currentChatRoom);
}

class _MessagesState extends State<Messages> {
  _MessagesState({@required this.currentChatRoom});

  ChatRoomModel currentChatRoom;
  Future<User> otherUser;
  TextEditingController messageControllor = TextEditingController();

  //////////////////////////////////////////////////////
  User host = User(id: "id", name: "Aqib");
  bool valueChanged = false;

//  User otherUser = User(id: "fjsdklfjkl",name: "Other");
//   MessagesModel message = MessagesModel(senderId: "fjsdklfjkl",msg: "Hello brother, How are you?");
//   MessagesModel message2 = MessagesModel(senderId: "id",msg: "Hello brother");
//   MessagesModel message3 = MessagesModel(senderId: "fjsdklfjkl",msg: "Hello brother");
//   List<MessagesModel> messageList = List();
  ///////////////////////////////////////////////////
  @override
  void initState() {
    otherUser = UserViewModel().getUserWithId(currentChatRoom.userIds.last);
    Firestore.instance.collection('Messages').where('roomId', isEqualTo: currentChatRoom.id).snapshots().listen((newMsgQuery) {
        setState(() {
          valueChanged = true;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: otherUser,
      builder: (BuildContext context, AsyncSnapshot<User> snapShot) {
        if (snapShot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapShot.data.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: AppSizes.height * .8,
                    color: Colors.grey[200],
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FutureBuilder(
                        future: MessagesViewModel()
                            .getAllMessagesOfRoom(currentChatRoom.id),
                        builder: (BuildContext contex,
                            AsyncSnapshot<List<MessagesModel>> msgSnapshot) {
                          if (msgSnapshot.hasData) {
                            return ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Container(),
                              itemCount: msgSnapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (msgSnapshot.data
                                        .elementAt(index)
                                        .senderId ==
                                    host.id) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(40.0),
                                              bottomRight:
                                                  const Radius.circular(40.0),
                                              bottomLeft:
                                                  const Radius.circular(40.0),
                                            )),
                                        //color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(msgSnapshot.data
                                              .elementAt(index)
                                              .message),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  // if (messageList.elementAt(index).senderId == otherUser.id){

                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: new BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: new BorderRadius.only(
                                              topRight:
                                                  const Radius.circular(40.0),
                                              bottomRight:
                                                  const Radius.circular(40.0),
                                              bottomLeft:
                                                  const Radius.circular(40.0),
                                            )),
                                        //color: Colors.green,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            msgSnapshot.data
                                                .elementAt(index)
                                                .message,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          } else
                            return Container(child: Text("Loading messages"));
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: AppSizes.height * .1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Container(
                              width: AppSizes.width * .7,
                              child: TextFormField(
                                controller: messageControllor,
                                decoration: InputDecoration(
                                    hintText: "Start typing message..."),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  if (messageControllor.text.toString() == "") {
                                    ApplicationToast.getSuccessToast(
                                        msg: "type something to send");
                                    return;
                                  }
                                  MessagesModel msg = MessagesModel(
                                      senderId: host.id,
                                      msg: messageControllor.text.toString(),
                                      roomId: currentChatRoom.id);
                                  MessagesViewModel().sendMsg(msg);
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
        } else {
          return Center(child: Text("LOADING messages..."));
        }
      },
    );
  }
}
