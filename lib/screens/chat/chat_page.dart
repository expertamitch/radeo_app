import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/models/chat_list_model.dart';
import 'package:redeo/screens/chat/chat_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController controller = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      controller.getChatList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          isBack: Get.arguments != null,
          title: 'Chat',
        ),
        body: Obx(() => controller.chatsLoading.value
            ? OnScreenLoader()
            : controller.chatList.isEmpty
                ? NotFoundWidget(
                    title: 'No chats found',
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(color: AppColors.greyColor),
                    itemCount: controller.chatList.length,
                    itemBuilder: (context, index) {
                      return messageListTile(controller.chatList.value[index]);
                    })));
  }

  messageListTile(ChatListItem item) {
    return GestureDetector(
      onTap: () async {
        print('yo');
        await Get.toNamed(Routes.chatMessageScreen,
            arguments: {"uid": item.user!.id!.toString(),"name":"${item.user!.firstName ?? ''} ${item.user!.lastName ?? ''}"});

     controller.getChatList();
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.purpleColor,
          child: Text(
            getInitials(
                "${item.user!.firstName ?? ''} ${item.user!.lastName ?? ''}"),
            style: w900_12(
              color: Colors.white,
            ),
          ),
        ),
        minLeadingWidth: 10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "${item.user!.firstName ?? ''} ${item.user!.lastName ?? ''}",
                overflow: TextOverflow.ellipsis,
                style: w900_14(),
              ),
            ),
            Text(
              timeago.format(item.user!.message!.createdAt!),
              style: false ? w900_12() : w300_12(),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            item.user?.message?.messageContent ?? '',
            style: false
                ? w900_12()
                : w300_12(
                    color: Colors.grey,
                  ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
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
}
