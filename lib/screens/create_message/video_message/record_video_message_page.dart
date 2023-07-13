import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/screens/create_message/text_message/show_text_message_sheet.dart';
import 'package:redeo/screens/create_message/video_message/video_page.dart';
import 'package:redeo/styling/font_style_globle.dart';

import '../../../../../assets/images.dart';
 import '../../../../../styling/app_colors.dart';

import '../../../../../widgets/image_view.dart';
import 'package:redeo/widgets/app_button.dart';

import '../message_controller.dart';

class RecordVideoMessagePage extends StatefulWidget {
  const RecordVideoMessagePage({Key? key}) : super(key: key);

  @override
  State<RecordVideoMessagePage> createState() => _RecordVideoMessagePageState();
}

class _RecordVideoMessagePageState extends State<RecordVideoMessagePage> {
  MessageController getController = Get.find();
  TextEditingController textMessageController = TextEditingController();

  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final cameras = await availableCameras();
      final front = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);
      _cameraController = CameraController(front, ResolutionPreset.max);
      await _cameraController.initialize();
      setState(() => _isLoading = false);
    }
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Row(
              children: [
                AppButton(
                    onPressedFunction: () {},
                    child: Text(
                      'Next',
                      style: w300_12(color: Colors.white),
                    ),
                    sodiumShapeBorder: true,
                    width: null,
                    height: 30.h,
                    buttonColor: AppColors.purpleColor)
              ],
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              'Record Video',
              style: w900_30(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  if (_isLoading)
                    Container(
                      color: Colors.white,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CameraPreview(_cameraController),
                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: FloatingActionButton(
                              backgroundColor: Colors.red,
                              child: Icon(
                                  _isRecording ? Icons.stop : Icons.circle),
                              onPressed: () => _recordVideo(),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ])))
        ]));
  }
}
