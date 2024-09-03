import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  static double volume = 100;
  static bool muted = false;
  static bool isPlayerReady = false;

  const VideoWidget({Key key,@required this.url }) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {

    return  Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            offset: Offset(0, 0),
            spreadRadius: 0.1,
          ),
        ],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child:getVideo(widget.url)),
    );



  }

  getIdVideo(String url){
    var id = YoutubePlayer.convertUrlToId(
      url,
    );
    return id;

  }
  Widget getVideo(String url){
    YoutubePlayerController youtubePlayerController;
    if(youtubePlayerController==null){
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: getIdVideo(url),
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
    }

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: youtubePlayerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              youtubePlayerController.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),

        ],
        onReady: () {
          VideoWidget.isPlayerReady = true;
        },

      ),
      builder: (context, player) => Scaffold(


        body: ListView(
          children: [
            player,

          ],
        ),
      ),
    );
  }

  void listener() {

  }

}

