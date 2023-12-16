import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  String mobileNo = '';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Add Contact',
        button1: 'Add',
        isBack: true,
        buttonTap1: () {},
      ),
      body: Container(

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
                      'Name',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    TextFormField(
                      style: w300_13(),
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: nameController,
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
                      'Mobile Number',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        mobileNo = number.phoneNumber.toString();
                        // .replaceAll(number.dialCode.toString(), "");
                        print(number.phoneNumber);
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
                      textStyle:w300_13(),

                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                      inputDecoration: InputDecoration(
                        hintStyle: w300_13(),
                        hintText: 'Mobile',contentPadding: EdgeInsets.only(bottom:16 ),
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
    );
  }
}
