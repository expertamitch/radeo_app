import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

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
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              'John Doe',
              style: w900_30(),
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
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.circular(22)),
                    padding: EdgeInsets.all(8),
                    child: Row(children: [
                      Flexible(
                          child: TextFormField(
                        style: w300_14(),
                        decoration: InputDecoration(
                            hintStyle: w300_14(
                              color: AppColors.dark2GreyColor,
                            ),
                            contentPadding:
                                EdgeInsets.only(bottom: 10, left: 10),
                            hintText: 'Message',
                            border: InputBorder.none),
                      )),
                      SizedBox(
                        width: 10.w,
                      ),
                      ImageView(
                        path: Images.attachIcon,
                        color: Colors.grey,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      ImageView(
                        path: Images.cameraIcon,
                        color: Colors.grey,
                        width: 20,
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
                SvgPicture.asset(
                  Images.sendIcon,
                  height: 45,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
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
                style: w300_14(color: user1Msg ? Colors.white : Colors.black),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                DateFormat('MMM d, yyyy').format(dateTime),
                style: w300_12(
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
}
