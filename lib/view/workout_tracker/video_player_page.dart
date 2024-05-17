import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

enum Source { Asset, Network }

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<StatefulWidget> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CustomVideoPlayerController _customVideoPlayerController;
  Source currentSource = Source.Asset;
  String assetVideoPath = "assets/videos/test.mp4";
  Uri videoUrl = Uri.parse(
      "https://videos.pexels.com/video-files/3048952/3048952-uhd_3840_2160_24fps.mp4");
  late bool isLoading = true;
  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(currentSource);
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    CustomVideoPlayer(
                      customVideoPlayerController: _customVideoPlayerController,
                    ),
                    _sourceButtons()
                  ]));
  }

  Widget _sourceButtons() {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
              color: Colors.blue,
              child: Text("Network Video"),
              onPressed: () {
                setState(() {
                  currentSource = Source.Network;
                  initializeVideoPlayer(currentSource);
                });
              }),
          MaterialButton(
              color: Colors.blue,
              child: Text("Asset Video"),
              onPressed: () {
                setState(() {
                  currentSource = Source.Asset;
                  initializeVideoPlayer(currentSource);
                });
              })
        ]);
  }

  void initializeVideoPlayer(Source source) {
    VideoPlayerController _videoPlayerController;
    if (source == Source.Asset) {
      _videoPlayerController = VideoPlayerController.asset(assetVideoPath)
        ..initialize().then((value) {
          setState(() {
            isLoading = false;
          });
        });
    } else if (source == Source.Network) {
      _videoPlayerController = VideoPlayerController.networkUrl(videoUrl)
        ..initialize().then((value) {
          setState(() {
            isLoading = false;
          });
        });
    } else {
      return;
    }
    _customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: _videoPlayerController);
  }
}
