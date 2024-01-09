import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:redeo/models/all_redeo_member_list_response_model.dart';
import 'package:redeo/screens/create_contact/add_contact_controller.dart';

import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../utils/validators.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/colors.dart';
import '../../../widgets/common_app_bar.dart';

class AddManualContact extends StatefulWidget {
  @override
  _AddManualContactState createState() => _AddManualContactState();
}

class _AddManualContactState extends State<AddManualContact> {
  String code = '+91';
  String mobileNo = '';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  AddContactController addContactController = Get.find();
  ContactInfo? contactInfo;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    contactInfo = Get.arguments;

    if (contactInfo != null) {
      mobileNo = contactInfo!.mobile!;
code=contactInfo!.country_code!;
      fNameController.text = contactInfo!.firstName!;
      lNameController.text = contactInfo!.lastName ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: contactInfo == null ? 'Add Contact' : 'Edit Contact',
        button1: contactInfo == null ? 'Add' : 'Save',
        isBack: true,
        buttonTap1: () async {
          if ((_formKey.currentState!.validate())) {
            if (contactInfo == null) {
              bool success = await addContactController.createContact(
                  fNameController.text, lNameController.text, mobileNo, code);
              if (success) Get.back();
            } else {
              bool success = await addContactController.editContact(
                  fNameController.text,
                  lNameController.text,
                  mobileNo,
                  contactInfo!.id!.toString(), code);
              if (success) Get.back();
            }
          }
        },
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
                        style: w300_13(
                          color: AppColors.blueColor,
                        ),
                      ),
                      TextFormField(
                        style: w300_13(),
                        validator: (value) => Validators.validateName(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: fNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintStyle: w300_13(),
                          hintText: 'Name',
                          border: InputBorder.none,
                          prefixIconConstraints:
                              BoxConstraints(maxWidth: 20, minWidth: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.greyColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Name',
                        style: w300_13(
                          color: AppColors.blueColor,
                        ),
                      ),
                      TextFormField(
                        style: w300_13(),
                        validator: (value) => Validators.validateName(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: lNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintStyle: w300_13(),
                          hintText: 'Last name',
                          border: InputBorder.none,
                          prefixIconConstraints:
                              BoxConstraints(maxWidth: 20, minWidth: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.greyColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Number',
                        style: w300_13(
                          color: AppColors.blueColor,
                        ),
                      ),
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          code = number.dialCode!;
                          mobileNo = number.parseNumber();
                          print(number.parseNumber());
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        validator: (value) {
                          return Validators.validateMobile(value);
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        keyboardAction: TextInputAction.done,
                        spaceBetweenSelectorAndTextField: 0,
                        selectorTextStyle: w300_13(),
                        initialValue: number,
                        maxLength: 10,
                        formatInput: false,
                        textStyle: w300_13(),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        inputDecoration: InputDecoration(
                          hintStyle: w300_13(),
                          hintText: 'Mobile',
                          contentPadding: EdgeInsets.only(bottom: 16),
                          border: InputBorder.none,
                          prefixIconConstraints:
                              BoxConstraints(maxWidth: 20, minWidth: 20),
                        ),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.greyColor,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
