import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/models/chat_history_model.dart';
import 'package:redeo/network/storage_utils.dart';
import 'package:redeo/screens/chat/chat_controller.dart';
import 'package:redeo/widgets/image_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/bottom_sheet_widget.dart';

class ChatMessagePage extends StatefulWidget {
  const ChatMessagePage({Key? key}) : super(key: key);

  @override
  State<ChatMessagePage> createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  ChatController controller = Get.find();

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  TextEditingController messageController = TextEditingController();
  String? filePath;
  String uid = Get.arguments["uid"];
  bool startRefresh = true;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500)).then((value) async {
      await controller.getChatHistory(uid);
      // refresh();
    });

    initPusher();

    super.initState();
  }

  refresh() async {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      await controller.refreshChat(uid);
      if (startRefresh) refresh();
    });
  }

/*
  Pusher keys

  PUSHER_APP_ID=1681022
  PUSHER_APP_KEY=56033aefb471f52cde31
  PUSHER_APP_SECRET=4ab20d4e39973036485b
  PUSHER_APP_CLUSTER=ap2

  channel = user-chat-<reciever-user-id>
  event = chatEvent
  */

  initPusher() async {
    try {
      await pusher.init(
        apiKey: '6ced992fdd260089f2d8',
        cluster: 'ap2',
        onConnectionStateChange: (sf, s) {
          print('Connection change');
        },
        onError: (error, e, r) {
          print('Error on' + r);
        },
        onSubscriptionSucceeded: (
          e,
          w,
        ) {
          print('onSubscriptionSucceeded');
        },
        onEvent: (
          er,
        ) {
          if (controller.messagesList.value.length == 0) {
            controller.messagesList.value.add(MessageItemData.fromJson(
                json.decode(er.data.toString())['msg']));
          } else {
            controller.messagesList.value.insert(
                0,
                MessageItemData.fromJson(
                    json.decode(er.data.toString())['msg']));
          }

          controller.messagesList.refresh();
        },
      );
      await pusher.subscribe(channelName: 'user-chat-$uid');
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.messagesList.clear();
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: AppColors.darkGreyColor,
            elevation: 0,

            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Column(children: [
            Container(
              width: double.maxFinite,
              color: AppColors.darkGreyColor,
              padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
              child: Text(
                Get.arguments["name"],
                style: w900_30(),
              ),
            ),
            Expanded(
                child: Obx(() => ListView.builder(
                    reverse: true,
                    itemCount: controller.messagesList.value.length,
                    itemBuilder: (context, index) {
                      return chatMessageTile(
                        message: controller.messagesList.value[index],
                        user1Msg: controller.messagesList.value[index].userId!
                                .toString() ==
                            StorageUtils.getUid(),
                      );
                    }))),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.darkGreyColor,
                          borderRadius: BorderRadius.circular(22)),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(children: [
                        Flexible(
                            child: TextFormField(
                          style: w300_14(),
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          controller: messageController,
                          decoration: InputDecoration(
                              hintStyle: w300_14(
                                color: AppColors.dark2GreyColor,
                              ),
                              contentPadding:
                                  EdgeInsets.only(bottom: 4, top: 4, left: 10),
                              hintText: 'Message',
                              border: InputBorder.none),
                        )),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            showIdTypeBottomSheet();
                          },
                          child: ImageView(
                            path: Images.attachIcon,
                            color: Colors.grey,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            XFile? pickedFile = await ImagePicker().pickImage(
                                source: ImageSource.camera,
                                imageQuality: 40
                            );
                            if (pickedFile != null) {
                              filePath =   pickedFile.path ;


                           /* FilePickerResult? result = await FilePicker.platform
                                .pickFiles(type: FileType.image);

                            if (result != null) {
                              filePath = result.files.single.path!;*/

                              String m = messageController.text;
                              messageController.text = '';

                              controller.sendMessage(
                                  messageType: 'message',
                                  forUser: uid,
                                  message: m,
                                  path: filePath);

                              filePath = null;
                              setState(() {});
                            }
                          },
                          child: ImageView(
                            path: Images.cameraIcon,
                            color: Colors.grey,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (messageController.text.isNotEmpty) {
                        String m = messageController.text;
                        messageController.text = '';

                        controller.sendMessage(
                            messageType: 'message',
                            forUser: uid,
                            message: m,
                            shouldShowLoader: false);

                        // setState(() {});
                        // FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    child: SvgPicture.asset(
                      Images.sendIcon,
                      height: 45,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ])),
    );
  }

  chatMessageTile({required bool user1Msg, required MessageItemData message}) {
    return Row(
      mainAxisAlignment:
          user1Msg ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.all(18),
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              color:
                  user1Msg ? AppColors.purpleColor : AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(18)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.attachments != null &&
                  message.attachments!.isNotEmpty)
                Column(
                  children: [
                    (message.attachments![0].toLowerCase().endsWith('png') ||
                            message.attachments![0]
                                .toLowerCase()
                                .endsWith('jpg') ||
                            message.attachments![0]
                                .toLowerCase()
                                .endsWith('jpeg'))
                        ? ImageView(
                            path: message.attachments![0],
                          )
                        : GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(message.attachments![0]));
                            },
                            child: Text(
                              message.attachments![0],
                              style: w300_13(color: Colors.white).copyWith(
                                  decoration: TextDecoration.underline),
                            )),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                ),
              if (message.messageContent != null)
                Text(
                  message.messageContent ?? '',
                  style: w300_13(color: user1Msg ? Colors.white : Colors.black),
                ),
              if (message.messageContent != null)
                SizedBox(
                  height: 10.h,
                ),
              Text(
                DateFormat('h:mm a')
                    .format((message.createdAt!).toLocal())
                    .toLowerCase(),
                style: w300_13(
                  color: user1Msg ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
      ? bankAccountName
          .trim()
          .split(RegExp(' +'))
          .map((s) => s[0])
          .take(2)
          .join()
      : '';

  showIdTypeBottomSheet() {
    return Get.bottomSheet(
      BottomSheetWidget(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Select attachment type',
                style: w900_15(color: AppColors.dark2GreyColor),
              ),
              SizedBox(
                height: 25.h,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.height - 300),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          filePath = result.files.single.path!;

                          String m = messageController.text;
                          messageController.text = '';

                          controller.sendMessage(
                              messageType: 'article',
                              forUser: uid,
                              message: m,
                              path: filePath);

                          filePath = null;
                          setState(() {});
                          Get.back();
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: Get.width,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Text(
                          'Article',
                          style: w600_13(),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(type: FileType.video);

                        if (result != null) {
                          filePath = result.files.single.path!;

                          String m = messageController.text;
                          messageController.text = '';

                          controller.sendMessage(
                              messageType: 'video',
                              forUser: uid,
                              message: m,
                              path: filePath);

                          filePath = null;
                          setState(() {});
                          Get.back();
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: Get.width,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Text(
                          'Video',
                          style: w600_13(),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          filePath = result.files.single.path!;

                          String m = messageController.text;
                          messageController.text = '';

                          controller.sendMessage(
                              messageType: 'brouchers',
                              forUser: uid,
                              message: m,
                              path: filePath);

                          filePath = null;
                          setState(() {});
                          Get.back();
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: Get.width,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Text(
                          'Brochure',
                          style: w600_13(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  dispose() {
    startRefresh = false;
    super.dispose();
  }
}
