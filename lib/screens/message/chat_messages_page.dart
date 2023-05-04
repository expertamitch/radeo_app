import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/app_text_field.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

class ChatMessagePage extends StatefulWidget {
  const ChatMessagePage({Key? key}) : super(key: key);

  @override
  State<ChatMessagePage> createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
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
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
            child: AppText(
              text: 'John Doe',
              textSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 1)
                      return chatMessageTile(
                          user1Msg: true,
                          dateTime: DateTime.now(),
                          msg:
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et');
                    return chatMessageTile(
                        user1Msg: false,
                        dateTime: DateTime.now(),
                        msg:
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et');
                  })),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(22)),
                    padding: EdgeInsets.all(8),
                    child: Row(children: [
                      Flexible(
                          child: TextField(
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 10, left: 10),
                            hintText: 'Message',
                            border: InputBorder.none),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      ImageView(
                        path: Images.attachIcon,
                        color: Colors.grey,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ImageView(
                        path: Images.cameraIcon,
                        color: Colors.grey,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  Images.sendIcon,
                  height: 45,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ]));
  }

  chatMessageTile({
    required bool user1Msg,
    required DateTime dateTime,
    required String msg,
  }) {
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
              Text(
                msg,
                style: w500_14(color: user1Msg ? Colors.white : Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              AppText(
                text: DateFormat('MMM d, yyyy').format(dateTime),
                textSize: 12,
                color: user1Msg ? Colors.white : Colors.grey,
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
}
