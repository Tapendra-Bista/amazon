import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class Flash extends StatefulWidget {
  const Flash({super.key});

  @override
  State<Flash> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      "image/video.mp4",
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);
    playvideo(context);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
            : Container(),
      ),
    );
  }

  Future playvideo(context) async {
    _videoPlayerController.play();
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, "/firstpage");
  }
}
