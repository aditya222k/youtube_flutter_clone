import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoListItems extends StatefulWidget {
  VideoPlayerController videoPlayerController;
  bool looping;
  bool autoPlay = true;
  bool autoInitialize = true;

  VideoListItems({
    required this.videoPlayerController,
    required this.looping,
    required this.autoPlay,
    this.autoInitialize = true,
  });

  @override
  _VideoListItemsState createState() => _VideoListItemsState();
}

class _VideoListItemsState extends State<VideoListItems> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    print("Wiget AutoPLay Vlaue ${widget.autoInitialize}");

    setState(() {
      print("Wiget AutoPLay Vlaue ${widget.autoPlay}");

      _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        autoInitialize: true,
        showControls: true,
        aspectRatio: 16 / 9,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
      if (widget.autoPlay) {
        _chewieController.play();
      } else {
        _chewieController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Chewie(controller: _chewieController),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
