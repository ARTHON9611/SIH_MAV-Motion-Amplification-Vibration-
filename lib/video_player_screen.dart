import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class MultipleVideosDemo extends StatefulWidget {
  final String url;
  final String path1;
  final Map<String, dynamic> parameters;

  MultipleVideosDemo({
    Key? key,
    required this.path1,
    required this.url,
    required this.parameters
  }) : super(key: key);

  @override
  _MultipleVideosDemoState createState() => _MultipleVideosDemoState();
}

class _MultipleVideosDemoState extends State<MultipleVideosDemo> {
  late VideoPlayerController _controller1;
  bool _isController1Initialized = false;
  VlcPlayerController? _vlcController;
  late String _videoUrl;

  @override
  void initState() {
    super.initState();
    _controller1 = VideoPlayerController.file(File(widget.path1));
    print(widget.url);
    _controller1.initialize().then((_) {
      setState(() {
        _isController1Initialized = true;
        _uploadVideo();
      });
    });
  }

  Future<void> _initializeVlcController() async {
    _vlcController = VlcPlayerController.network(
      _videoUrl,
      hwAcc: HwAcc.auto,
      options: VlcPlayerOptions(),
    );
    await _vlcController!.initialize();
    setState(() {
      _vlcController!.play();
    });
  }

  Future<void> _uploadVideo() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Video uploaded")));
    final url = Uri.parse(
        widget.url.toString()+'/upload'); // Replace with your API upload endpoint
    final request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath('file', widget.path1),
    );
    request.fields.addAll(widget.parameters as Map<String,String>); // Add the parameters to the request

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        var jsonResponse = await response.stream.bytesToString();
        var parsedResponse = json.decode(jsonResponse);
        print(parsedResponse);
        if (parsedResponse['video_url'] != null) {
          setState(() {
            _videoUrl = parsedResponse['video_url'];
            _initializeVlcController();
          });
        } else {
          print('No video URL found in the response');
        }
      } else {
        print('Failed to upload video: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading video: $e');
    }
  }

  @override
  void dispose() {
    _controller1.dispose();
    _vlcController?.dispose();
    super.dispose();
  }

  void playPauseVideo1() {
    if (_controller1.value.isPlaying) {
    } else {
      setState(() {
        _controller1.play();
      });
    }
  }

  IconData getIconData(dynamic controller) {
    return controller is VideoPlayerController
        ? (controller.value.isPlaying ? Icons.pause : Icons.play_arrow)
        : IconData(0xe5cd, fontFamily: 'MaterialIcons');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_isController1Initialized)
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      'Original Video',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 10.0,
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: _controller1.value.aspectRatio,
                        child: VideoPlayer(_controller1),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: playPauseVideo1,
                      child: Icon(getIconData(_controller1)),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    'Processed Video',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  _vlcController != null
                      ? Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 10.0,
                            ),
                          ),
                          child: VlcPlayer(
                            controller: _vlcController!,
                            aspectRatio: 16 / 9,
                            placeholder: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                      : CircularProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _uploadVideo();
        },
        child: Icon(Icons.upload_file),
      ),
    );
  }
}
