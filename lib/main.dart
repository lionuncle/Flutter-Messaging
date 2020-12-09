import 'Utilities/AppSizes.dart';
import 'file:///D:/1-FLUTTER/Flutter-Messaging/lib/View/ChatRoom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    loadNext();
    AppSizes.initializeSize(context);
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text('JB-Messaging APP',textScaleFactor: 2, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text('BUILT FOR THE TEAM',textScaleFactor: 2, style: TextStyle(color: Colors.white, fontSize: 8)),
            ),
            SizedBox(height: 200,),


            Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text("Loading", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadNext()async{
    await Future.delayed((Duration(seconds: 2)));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>ChatRoom()));

  }

}


