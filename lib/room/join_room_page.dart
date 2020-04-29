import 'dart:async';

import 'package:flutter/material.dart';
import 'package:twilio_programmable_video/twilio_programmable_video.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage();

  @override
  State<StatefulWidget> createState() => RoomTest();
}

class RoomTest extends State<JoinRoomPage>{
  void _onConnected(Room room){
    print('Connected to ${room.name}');
  }

  void _onConnectFailure(RoomConnectFailureEvent event){
    print('Failed to connect to room ${event.room.name} with exception: ${event.exception}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Device Info')
        ),
        body: FutureBuilder<Room>(
          future: connectToRoom(),
          builder: (BuildContext context, AsyncSnapshot<Room> snapshot) {
            if(snapshot.connectionState != ConnectionState.done){
              return CircularProgressIndicator();
            }

            if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }

            if(!snapshot.hasData){;
              return Text("error");
            }
            final room = snapshot.data;
            room.onConnected.listen(_onConnected);
            room.onConnectFailure.listen(_onConnectFailure);

            var cameraCapturer = CameraCapturer(CameraSource.FRONT_CAMERA);
            var localVideoTrack = LocalVideoTrack(true, cameraCapturer);
            print('${localVideoTrack.isEnabled}');
            /*
            return Container(
              height: 400,
              width: 300,
              child: localVideoTrack.widget(),
            );
          */
            return Scaffold(
              appBar: AppBar(
                title: Text('join room page')
              ),
              body: localVideoTrack.widget()
            );
          }
        )
      )
    );
  }

  Future<Room> connectToRoom() {
    var accessToken = "Twilio Demo Signing Key";
    var connectOptions = ConnectOptions(
      accessToken,
    );
    return TwilioProgrammableVideo.connect(connectOptions);
  }
}