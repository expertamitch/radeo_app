import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redeo/models/phone_contact_model.dart';
import 'package:redeo/widgets/radio_selection_widget.dart';

import '../../assets/images.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

class ContactTile extends StatelessWidget{
  PhoneContactModel model;
  VoidCallback? onTap;
  bool showRadioButton;

  ContactTile({required this.model,
    this.onTap,
    this.showRadioButton=true
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},

      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.greyColor))),
        child: Row(children: [
          SvgPicture.asset(
            Images.peopleIcon,
            height: 23,
          ),
          SizedBox(
            width: 15.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.phoneContact.name.first} ${model.phoneContact.name.last}",
                style: w300_12(),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                model.phoneContact.phones[0].number,
                style: w300_10(
                  color: AppColors.dark2GreyColor,
                ),
              )
            ],
          ),
          Expanded(
            child: SizedBox(
              width: 15.w,
            ),
          ),
          if(showRadioButton)
          RadioSelectionWidget(selected: model.selected)
        ]),
      ),
    );
  }

}