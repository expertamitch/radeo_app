import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../assets/images.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/image_view.dart';

class AddInviteePage extends StatefulWidget {
  const AddInviteePage({Key? key}) : super(key: key);

  @override
  State<AddInviteePage> createState() => _AddInviteePageState();
}

class _AddInviteePageState extends State<AddInviteePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.darkGreyColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Add invitee',
          style: w600_16(color: Colors.black),
        ),
        actions: [
          Row(
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: AppColors.purpleColor),
                    onPressed: () {},
                    child: AppText(
                      text: 'Save',
                      textSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Invitee Name',
                    textSize: 15,
                    color: AppColors.blueColor,
                  ),
                  TextFormField(
                    style: w300_14(),
                    decoration: InputDecoration(
                        hintStyle: w300_14(
                          color: AppColors.dark2GreyColor,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Name'),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: AppColors.greyColor),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: 'Select Contacts',
                    textSize: 15,
                    color: AppColors.blueColor,
                  ),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            primary: AppColors.purpleColor),
                        onPressed: () {
                          Get.toNamed(Routes.inviteeScreen);
                        },
                        child: AppText(
                          text: 'Select',
                          textSize: 12,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
