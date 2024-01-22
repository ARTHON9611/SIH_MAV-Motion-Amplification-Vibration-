import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mav/video_edit_screen.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
  Map<String, String> parameters;
  UploadScreen({required this.parameters});
}

class _UploadScreenState extends State<UploadScreen> {
  File? _video;
  TextEditingController _urlController = TextEditingController();

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    _video = File(pickedVideo!.path);
    Navigator.push(context, MaterialPageRoute(builder: (context) => VideoEditor(file: File(_video!.path), url: _urlController.text,parameters: widget.parameters,)));
  }
  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Video'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _pickVideo,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: const Text(
                  'Pick Video',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _urlController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Server URL',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
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
}
