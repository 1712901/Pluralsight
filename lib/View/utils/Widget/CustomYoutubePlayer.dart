import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutuberPlayer extends StatefulWidget {
  final String url;
  final bool next;
  const CustomYoutuberPlayer({Key key, @required this.url,@required this.next}) : super(key: key);
  @override
  _CustomYoutuberPlayerState createState() => _CustomYoutuberPlayerState();
}

class _CustomYoutuberPlayerState extends State<CustomYoutuberPlayer> {
  YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
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
    if(widget.next) _youtubePlayerController.load(YoutubePlayer.convertUrlToId(widget.url));
    return YoutubePlayer(
      controller: _youtubePlayerController,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
        PlaybackSpeedButton(),
        RemainingDuration(),
      ],
    );
  }
}
