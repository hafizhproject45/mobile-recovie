import 'package:flutter/material.dart';
import '../../../core/utils/text_style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeIframe extends StatefulWidget {
  final String title;
  final String ytKey;

  const YoutubeIframe({
    required this.title,
    required this.ytKey,
    super.key,
  });

  @override
  State<YoutubeIframe> createState() => _YoutubeIframeState();
}

class _YoutubeIframeState extends State<YoutubeIframe> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.ytKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        disableDragSeek: true,
      ),
    );

    // Add listener for video end event
    // _controller.addListener(() {
    //   if (_controller.value.isPlaying &&
    //       _controller.value.position.inSeconds >=
    //           _controller.metadata.duration.inSeconds - 2) {
    //     _controller.pause();
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return YoutubePlayer(
      bufferIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
      aspectRatio: 16 / 9,
      controller: _controller,
      showVideoProgressIndicator: true,
      progressColors: const ProgressBarColors(
        playedColor: Colors.red,
        bufferedColor: Colors.grey,
      ),
      topActions: [
        SizedBox(
          width: screenWidth * 0.9,
          child: Text(
            widget.title,
            style: AppTextStyle.mediumWhite,
          ),
        )
      ],
      progressIndicatorColor: Colors.red,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(
          isExpanded: true,
          colors: const ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.redAccent,
          ),
        ),
        RemainingDuration()
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
