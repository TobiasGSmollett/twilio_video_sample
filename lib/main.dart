import 'package:flutter/material.dart';
import 'package:twilio_programmable_video/twilio_programmable_video.dart';
import 'package:twiliovideosample/room/join_room_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twilio Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: JoinRoomPage(),
      home: JoinRoomPage(),
    );
  }
}
