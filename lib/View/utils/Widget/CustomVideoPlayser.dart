import 'dart:io';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/service/LessonService.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String url;
  final next;
  final double seek;
  final isLocal;
  final String lessonId;

  const CustomVideoPlayer(
      {Key key,
      @required this.url,
      @required this.next,
      @required this.isLocal,
      @required this.lessonId,
      this.seek = 0})
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
   _videoPlayerController?.removeListener(videoListener);
   _videoPlayerController?.pause(); // mute instantly
   _videoPlayerController?.dispose();
   _videoPlayerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: initializePlayer(url: widget.url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("Done");
              if (_chewieController != null) {
                return Chewie(controller: _chewieController);
              }
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
      ),
    );
  }

  Future<void> initializePlayer({@required String url}) async {
    if (widget.next||_videoPlayerController!=null) {
      print("dispose");
      await _videoPlayerController.dispose();
    }

    if (widget.isLocal) {
      try {
        _videoPlayerController = VideoPlayerController.file(File(url));
      } catch (exp) {
        _videoPlayerController = VideoPlayerController.network(url);
      }
    } else {
      _videoPlayerController = VideoPlayerController.network(url);
      print("initialize");
    }
    print(widget.url);
    await _videoPlayerController.initialize();

    _videoPlayerController.addListener(videoListener);
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
    if (widget.seek >= 1) {
      _showDiolog(context);
    }
  }

  Future<void> initializePlayer2({@required String url}) async {
    VideoPlayerController controller;
    if (widget.isLocal) {
      try {
        controller = VideoPlayerController.file(File(url));
      } catch (exp) {
        controller = VideoPlayerController.network(url);
      }
    } else {
      controller = VideoPlayerController.network(url);
      print("initialize");
    }
    final old = _videoPlayerController;
    _videoPlayerController = controller;
    if (old != null) {
      //old.removeListener(_onControllerUpdated);
      old.pause();
      debugPrint("---- old contoller paused.");
    }

    print(widget.url);
    await _videoPlayerController.initialize();
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
    if (widget.seek > 0) {
      _showDiolog(context);
    }
  }

  void _showDiolog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
                "Bạn đã xem đến ${Format.convertSecondTo(Duration(seconds: widget.seek.toInt()))}"),
            actions: [
              FlatButton(
                  onPressed: () {
                    _videoPlayerController
                        .seekTo(Duration(seconds: (widget.seek).toInt()));
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Tiếp tục")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Hủy"))
            ],
          );
        });
  }
  videoListener(){
    try {
      AccountInf accountInf = Provider.of<AccountInf>(context, listen: false);
      bool equal = widget.lessonId.toLowerCase() == ("Intro".toLowerCase());
      if (accountInf.isAuthorization()) {
        if (_videoPlayerController.value.position ==
            _videoPlayerController.value.duration) {
          if (!equal) {
            LessonService.updateStatus(
                token: accountInf.token, lessonId: widget.lessonId);
          }
        }
        if (!_videoPlayerController.value.isPlaying && !equal) {
          double currentTime = _videoPlayerController.value.position.inSeconds
              .toDouble();
          print(currentTime);
          if (currentTime > widget.seek)
            LessonService.updateCurrentTime(token: accountInf.token,
                lessonId: widget.lessonId,
                currentTime: currentTime);
        }
      }
    }catch(e){
      print("fgfdgdfg");
      print(e.toString());
    }
  }
}
