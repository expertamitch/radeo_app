import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/event/event_controller.dart';
import 'package:redeo/utils/snackbar_util.dart';
import 'package:redeo/utils/validators.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../../assets/images.dart';
import '../../../models/event_detail_model.dart';
import '../../../models/events_model.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/loader.dart';
import '../../territory/controller/contacts_controller.dart';

class AddInviteePage extends StatefulWidget {
  const AddInviteePage({Key? key}) : super(key: key);

  @override
  State<AddInviteePage> createState() => _AddInviteePageState();
}

class _AddInviteePageState extends State<AddInviteePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  String mobile = '';
  String event_id = '';
  EventController eController = Get.find();

  late EventInfoModel model;

  @override
  void initState() {
    model = Get.arguments;

    super.initState();
  }

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
          'Add Invitee',
          style: w900_18(color: Colors.black),
        ),
        actions: [
          Row(
            children: [
              AppButton(
                  onPressedFunction: () async {
                    if (!_formKey.currentState!.validate()!) {

                    } else if (event_id.isEmpty) {
                      showErrorSnackBar('Please scan QR code');
                    } else {
                      Map<String, dynamic> data = {};

                      data['name'] = nameController.text;
                      if (mobile.isNotEmpty) data['mobile'] = mobile;

                      data['qr_code_id'] = event_id;

                      EventDetailModel? result = await eController.addInvitee(
                          data, model.id!.toString());
                      if (result != null && result.info != null) {
                        showLoader();
                        await eController.getEventsList();
                        hideLoader();
                        Get.back(result: result.info);
                      }
                    }
                  },
                  child: Text(
                    'Save',
                    style: w300_12(color: Colors.white),
                  ),
                  height: 30.h,
                  sodiumShapeBorder: true,
                  width: null,
                  buttonColor: AppColors.purpleColor)
            ],
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invitee Name',
                            style: w300_13(
                              color: AppColors.blueColor,
                            ),
                          ),
                          TextFormField(
                            style: w300_13(),
                            controller: nameController,
                            validator: (value) {
                              return Validators.validateName(value);
                            },
                            decoration: InputDecoration(
                                hintStyle: w300_13(),
                                border: InputBorder.none,
                                hintText: 'Enter Name'),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, color: AppColors.greyColor),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Select Contacts',
                                style: w300_13(
                                  color: AppColors.blueColor,
                                ),
                              ),
                              Text(
                                mobile,
                                style: w600_13(
                                  color: AppColors.blueColor,
                                ),
                              )
                            ],
                          ),
                          AppButton(
                              onPressedFunction: () async {
                                await Get.toNamed(Routes.inviteContactsScreen);
                                ContactsController controller = Get.find();
                                mobile = '';
                                for (int i = 0;
                                    i < controller.contacts.value.length;
                                    i++) {
                                  if (controller.contacts.value[i].selected) {
                                    mobile = controller.contacts.value[i]
                                        .phoneContact.phones[0].number;
                                    setState(() {});
                                  }
                                }

                                controller.tempRedeoList.value.forEach((element) {
                                  if (element.selected) {
                                    mobile = element.mobile!;
                                    setState(() {});
                                  }
                                });

                                setState(() {});
                              },
                              child: Text(
                                'Select',
                                style: w300_12(color: Colors.white),
                              ),
                              sodiumShapeBorder: true,
                              width: null,
                              height: 30.h,
                              buttonColor: AppColors.purpleColor)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                height: 45.h,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: AppColors.purpleColor),
                    onPressed: () {
                      event_id = '';
                      Get.toNamed(Routes.qrScanner)?.then((value) {
                        if (value != null) {
                          setState(() async {
                            if (value.toString().split('/').last.indexOf('-') >
                                0) {
                              event_id = value.toString().split('/').last;

                            } else {
                              showErrorSnackBar('Invalid Redeo QR');
                            }
                          });
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageView(
                          path: Images.qrCodeScanIcon,
                          color: Colors.white,
                          height: 23,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Scan QR code',
                          style: w900_14(color: Colors.white),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
