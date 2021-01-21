import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/service/LessonService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutuberPlayer extends StatefulWidget {
  final String url;
  final bool next;
  final double seek;
  final String lessonId;

  const CustomYoutuberPlayer(
      {Key key,
      @required this.url,
      @required this.next,
      this.seek = 0,
      @required this.lessonId})
      : super(key: key);

  @override
  _CustomYoutuberPlayerState createState() => _CustomYoutuberPlayerState();
}

class _CustomYoutuberPlayerState extends State<CustomYoutuberPlayer> {
  YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ));
    super.initState();
  }

  @override
  void dispose() {
    if (_youtubePlayerController != null) _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.next) {
      _youtubePlayerController.load(YoutubePlayer.convertUrlToId(widget.url));
      //_showDiolog(context);
    }
    return YoutubePlayer(
      controller: _youtubePlayerController,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
        PlaybackSpeedButton(),
        RemainingDuration(),
      ],
      onEnded: (value) {
        print("endVideo ${value.duration}");
        AccountInf accountInf = Provider.of<AccountInf>(context, listen: false);
        bool equal = widget.lessonId.toLowerCase() == ("Intro".toLowerCase());
        if (!equal) {
          LessonService.updateStatus(
              token: accountInf.token, lessonId: widget.lessonId);
        }
      },
      onReady: () {
        if (widget.seek != null && widget.seek > 0) _showDiolog(context);

        _youtubePlayerController.addListener(() {
          AccountInf accountInf =
              Provider.of<AccountInf>(context, listen: false);
          bool equal = widget.lessonId.toLowerCase() == ("Intro".toLowerCase());
          if (accountInf.isAuthorization()) {
            if (!_youtubePlayerController.value.isPlaying && !equal) {
              Duration duration = _youtubePlayerController.value.position;
              if (duration != null) {
                double currentTime = _youtubePlayerController
                    .value.position.inSeconds
                    .toDouble();
                print(currentTime);
                if (widget.seek == null || currentTime > widget.seek)
                  LessonService.updateCurrentTime(
                      token: accountInf.token,
                      lessonId: widget.lessonId,
                      currentTime: currentTime);
              } else {
                print("sdfds");
              }
            }
          }
        });
      },
    );
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
                    _youtubePlayerController
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
}
