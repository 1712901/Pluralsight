import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String url;
  final next;

  const CustomVideoPlayer({Key key, @required this.url, @required this.next})
      : super(key: key);
  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    //initializePlayer(url: widget.url);
    //_videoPlayerController = VideoPlayerController.network(widget.url);
    super.initState();
  }

  @override
  void dispose() {
    if (_videoPlayerController != null)
      _videoPlayerController.dispose();
    if (_chewieController != null) _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: initializePlayer(url: widget.url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("Done");
            if (_chewieController != null)
              return Chewie(controller: _chewieController);
            print("No");
            return Container();
          } else {
            print("No");
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> initializePlayer({@required String url}) async {
    if (widget.next) {
      _videoPlayerController.dispose();

      _videoPlayerController = VideoPlayerController.network(url);
      await _videoPlayerController.initialize();
    }else{
       _videoPlayerController = VideoPlayerController.network(url);
      await _videoPlayerController.initialize();
    }
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      //autoInitialize: true,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_arrow,
                size: 40,
              ),
              Text(errorMessage)
            ],
          ),
        );
      },
    );
  }
}
