import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';

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
        appBar:CustomAppBar(
          title: 'Chat',

        ),
        body: Column(children: [

          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: AppColors.greyColor),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return messageListTile(
                      isNewMsg: index == 0 ? true : false,
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
    required bool isNewMsg,
    required String title,
    required String subtitle,
    required String timeAgo,
    required String leadingIconPath,
  }) {
    return GestureDetector(
      onTap: () {
        print('yo');
        Get.toNamed(Routes.chatMessageScreen);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.purpleColor,
          child: Text(
            getInitials(title),
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
                title,
                overflow: TextOverflow.ellipsis,
                style: w900_14(),
              ),
            ),
            Text(
              timeAgo,
              style: isNewMsg ? w900_12() : w300_12(),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            subtitle,
            style: isNewMsg
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
