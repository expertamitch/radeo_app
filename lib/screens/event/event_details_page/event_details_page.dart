import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../assets/images.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/image_view.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({Key? key}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.editEventDetailsScreen);
                },
                child: Icon(Icons.edit)),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.delete),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Stack(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            height: 40,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        PrettyQr(
                          // image: AssetImage('images/twitter.png'),
                          typeNumber: 3,
                          size: 150,
                          data: 'https://www.google.ru',
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                          roundEdges: true, elementColor: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: 'Event Name',
                          textSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AppText(
                          text: '27 Apr 2023, 3:17 PM',
                          textSize: 14,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AppText(
                          text: '2006 Chapmans Lane, San Francisco, California',
                          textSize: 14,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.darkGreyColor,
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Description',
                          textSize: 15,
                          color: AppColors.blueColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero',
                            style: w500_12()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppText(
                    text: 'Client List',
                    textSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.darkGreyColor,
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        ImageView(
                          path: Images.searchIcon,
                          color: Colors.purple,
                        ),
                        SizedBox(width: 15),
                        Flexible(
                            child: TextFormField(
                          style: w500_14(),
                          decoration: InputDecoration(
                              hintStyle: w500_14(
                                color: AppColors.dark2GreyColor,
                              ),
                              border: InputBorder.none,
                              hintText: 'Serach Clients...',
                              isDense: true),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  clientLstTile(
                      status: 'Accepted',
                      subtitle:
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,sed diam nonumy eirmod.',
                      title: 'John Doe Client'),
                  clientLstTile(
                      status: 'Rejected',
                      subtitle:
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,sed diam nonumy eirmod.',
                      title: 'John Doe Client'),
                  clientLstTile(
                      status: 'Pending',
                      subtitle:
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,sed diam nonumy eirmod.',
                      title: 'John Doe Client'),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ]));
  }

  clientLstTile(
      {required String title,
      required String subtitle,
      required String status}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.greyColor))),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(),
          SizedBox(
            width: 15,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: w500_14()),
                SizedBox(
                  height: 5,
                ),
                Text(
                  subtitle,
                  style: w500_12(color: AppColors.dark2GreyColor),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: w500_12(
                color: status == 'Accepted'
                    ? AppColors.greenColor
                    : status == 'Rejected'
                        ? AppColors.redColor
                        : Colors.black),
          ),
        ],
      ),
    );
  }
}
