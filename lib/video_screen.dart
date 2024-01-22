import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class videoScreen extends StatefulWidget {
  final File video;

  videoScreen({super.key, required this.video});

  @override
  _videoScreenState createState() => _videoScreenState();
}

class _videoScreenState extends State<videoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(widget.video);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? videoWidget(_controller,context)
          : Container(),
    );
  }
}


Widget videoWidget(VideoPlayerController controller, BuildContext context) {
  return Padding(
    padding:  EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 0, // Adjust the elevation as needed
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Original Video",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
