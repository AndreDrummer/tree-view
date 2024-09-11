import 'dart:io';

import 'package:tree_view/core/constants/graphic_assets.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class BackgroundVideo extends StatefulWidget {
  const BackgroundVideo({super.key});

  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  late VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.asset(VideoAssets.loadingScreen.name)
          ..initialize().then((_) {
            setState(() {});
          });
    // ..play()
    // ..setLooping(true)
    // ..setVolume(0);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: (Platform.isAndroid || Platform.isIOS) ? 15 : 0,
      child: SizedBox.expand(child: VideoPlayer(_videoPlayerController)),
    );
  }
}
