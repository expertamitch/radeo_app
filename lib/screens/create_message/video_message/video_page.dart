import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/widgets/loader.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../video_info_bottom_sheet.dart';

class VideoPage extends StatefulWidget {
  final String filePath;

  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  MessageController controller = Get.find();

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              showLoader();
              MediaInfo? mediaInfo = await VideoCompress.compressVideo(
                widget.filePath,
                quality: VideoQuality.Res640x480Quality,
                includeAudio: true,
                deleteOrigin: false, // It's false by default
              );

              hideLoader();

              var data = await showVideoInfoBottomSheet(type: 'video');
              if (data != null) {
                int? id = await controller.saveVideoMessage(
                    title: data['name'],
                    thumbnailPath: data['file'],
                    videoPath: mediaInfo!.path!);
                if (id != null) {
                  Get.back(result: id);

                }
              }
            },
          )
        ],
      ),
      extendBodyBehindAppBar: false,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Center(
                    child: VideoPlayer(
                  _videoPlayerController,
                )),
              ),
            );
          }
        },
      ),
    );
  }
}
