import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: AppText(
              text: 'Message',
              textSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: AppColors.greyColor),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return messageListTile(
                      dateTime: DateTime.now(),
                      title: 'John Doe',
                      subtitle:
                          '2006 Chapmans Lane, San Francisc 2006 Chapmans Lane, San Franciscoo…',
                      timeAgo: '2 min ago',
                      leadingIconPath: Images.locationIcon,
                    );
                  }))
        ]));
  }

  messageListTile({
    required DateTime dateTime,
    required String title,
    required String subtitle,
    required String timeAgo,
    required String leadingIconPath,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.chatMessageScreen);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.purpleColor,
          child: AppText(
            text: getInitials(title),
            textSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        minLeadingWidth: 10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: w600_14(),
              ),
            ),
            Text(
              timeAgo,
              style: w500_12(),
            ),
          ],
        ),
        subtitle: AppText(
          text: subtitle,
          textSize: 12,
          color: Colors.grey,
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
