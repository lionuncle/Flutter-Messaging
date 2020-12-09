import 'package:firebase_messages/Model/User.dart';
import 'package:firebase_messages/ViewModel/ChatRoomViewModel.dart';
import 'package:firebase_messages/ViewModel/UserViewModel.dart';
import 'package:firebase_messages/Widgets/Widgets.dart';
import 'package:firebase_messages/animations/SlideRight.dart';
import 'package:flutter/material.dart';

class SelectUserToChat extends StatefulWidget {
  @override
  _SelectUserToChatState createState() => _SelectUserToChatState();
}

class _SelectUserToChatState extends State<SelectUserToChat>{

  Future<List<User>> futureLoadUsers;

  @override
  void initState() {
    super.initState();
    futureLoadUsers = UserViewModel().getAllUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<User>>(
              future: futureLoadUsers,
              builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
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
                              onTap: ()async{
                                // Scaffold.of(context).showSnackBar(SnackBar(
                                //   content: Text(index.toString()),
                                // ));
                                await ChatRoomViewModel().CreateNewRoomBetween(UserViewModel().getCurrentUser().id, snapshot.data.elementAt(index).id);
                                ApplicationToast.getSuccessToast(msg: "ChatRoom created");
                                Navigator.of(context).pop();
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

                                      Text(snapshot.data.elementAt(index).name),

                                    ],
                                  )
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),

                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text("LOADING USERS..."));
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}

