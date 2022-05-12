import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HappyMath extends StatelessWidget {
  //Full URL: https://www.youtube.com/watch?v=XRIBa_Mj3rs
  static String videoID = 'XRIBa_Mj3rs';

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  HappyMath({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset(
            "assets/title2.png",
            fit: BoxFit.contain,
            height: 150,
          ),
          toolbarHeight: 150,
        ),
        body: Column(children: <Widget>[
          SizedBox(height: 90),
          YoutubePlayer(
            controller: _controller,
            liveUIColor: Colors.amber,
            showVideoProgressIndicator: true,
          ),
        ]));
  }
}
