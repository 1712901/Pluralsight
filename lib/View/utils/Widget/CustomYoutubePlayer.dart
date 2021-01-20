import 'package:Pluralsight/Core/models/Format.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutuberPlayer extends StatefulWidget {
  final String url;
  final bool next;
  final double seek;
  const CustomYoutuberPlayer({Key key, @required this.url,@required this.next,this.seek=0}) : super(key: key);
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
      )
    );
    super.initState();
  }

  @override
  void dispose() {
    if (_youtubePlayerController != null) _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.next) {
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
      onReady: (){
        if(widget.seek!=null&&widget.seek>0)
        _showDiolog(context);
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
