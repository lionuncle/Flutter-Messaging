import 'package:firebase_messages/Model/User.dart';
import 'package:firebase_messages/ViewModel/ChatRoomViewModel.dart';
import 'package:firebase_messages/ViewModel/UserViewModel.dart';
import 'package:firebase_messages/Widgets/Widgets.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  List<User> users = List();
  @override
  void initState() {
    users.add(User(id: "123",name: "AQIB"));
    users.add(User(id: "123",name: "BANANA"));
    users.add(User(id: "123",name: "ORANGE"));
    users.add(User(id: "123",name: "XCODE"));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

  createChat();


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Chat Room"),),
        body: ListView.separated(
          // padding: const EdgeInsets.all(8),
          itemCount: users.length,

          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(index.toString()),
                ));
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

                    Text(users[index].name),

                  ],
                )
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),

        )
      ),
    );
  }
  createChat() async{
    bool isCreated = await ChatRoomViewModel().CreateNewRoomBetween("userOneId", "userTwoId");
    if(isCreated){
      ApplicationToast.getSuccessToast(msg: "CREATED");
    }
    else ApplicationToast.getErrorToast(msg: "Already existing");
  }
}

