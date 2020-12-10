import 'package:firebase_messages/Model/ChatRoomModel.dart';
import 'package:firebase_messages/Model/MessagesModel.dart';
import 'package:firebase_messages/View/Messages.dart';
import 'package:firebase_messages/View/SelectUserToChat.dart';
import 'package:firebase_messages/ViewModel/ChatRoomViewModel.dart';
import 'package:firebase_messages/animations/SlideRight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Future<List<ChatRoomModel>> futureLoadChatRooms;

  @override
  void initState() {
    super.initState();
    futureLoadChatRooms = ChatRoomViewModel().getAllChatRoomsOfCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<ChatRoomModel>>(
              future: futureLoadChatRooms,
              builder: (BuildContext context, AsyncSnapshot<List<ChatRoomModel>> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        child: ListView.separated(
                          // padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,

                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){

                                    Navigator.of(context).push(SlideRightRoute(page: Messages(currentChatRoom: snapshot.data.elementAt(index),)));

                              },
                              child: Container(
                                  height: 100,
                                  color: Colors.grey[200],
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 60.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9b_tCGYcmhZzaQGBtZldeNwtTaqbG5cE3Zw&usqp=CAU")
                                              )
                                          )),

                                      Text(snapshot.data.elementAt(index).userIds.elementAt(1)),

                                    ],
                                  )
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),

                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                          onPressed: (){
                            Navigator.of(context).push(SlideRightRoute(page: SelectUserToChat()));
                          },
                          child: Icon(Icons.message),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(child: Text("LOADING Chat rooms..."));
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}

