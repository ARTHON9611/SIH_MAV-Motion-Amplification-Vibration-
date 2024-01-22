import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class Home extends StatefulWidget {
  @override
  _ExampleVideoState createState() => _ExampleVideoState();
}

class _ExampleVideoState extends State<Home> {
  late bool _isPlaying = true;
  final VlcPlayerController controller = VlcPlayerController.asset(
    "assets/boy.mp4",
    hwAcc: HwAcc.auto,
    options: VlcPlayerOptions(),
  );

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final isEnded = controller.value.isEnded;
      if (isEnded && _isPlaying) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 225,
            child: VlcPlayer(
              aspectRatio: 16 / 9,
              controller: controller,
              placeholder: const Center(child: CircularProgressIndicator()),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isPlaying)
                  TextButton(
                    onPressed: () {
                      controller.pause();
                      setState(() {
                        _isPlaying = false;
                      });
                    },
                    child: const Icon(
                      Icons.pause,
                      size: 50,
                    ),
                  )
                else
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isPlaying = true;
                        controller.play();
                      });
                    },
                    child: Icon(
                      Icons.play_arrow,
                      size: 50,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
