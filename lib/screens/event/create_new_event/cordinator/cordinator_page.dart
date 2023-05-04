import 'package:flutter/material.dart';
import 'package:redeo/styling/font_style_globle.dart';
import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/colors.dart';
import '../../../../widgets/image_view.dart';

class CordinatorPage extends StatefulWidget {
  const CordinatorPage({Key? key}) : super(key: key);

  @override
  State<CordinatorPage> createState() => _CordinatorPageState();
}

class _CordinatorPageState extends State<CordinatorPage> {
  String contactType = 'Group'; //Group, Contact, Redeo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: AppText(
            text: 'Coordinator',
            textSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Select Coordinator',
                style: w900_15(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.darkGreyColor,
                    borderRadius: BorderRadius.circular(8)),
                // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                          hintText: 'Search Coordinator…',
                          isDense: true),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return groupsTile('John Doe');
                  },
                ),
              )
            ])));
  }

  groupsTile(String title) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.greyColor))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        AppText(
          text: title,
          textSize: 16,
        ),
        Radio(
          value: false,
          groupValue: 'groupValue',
          onChanged: (value) {},
        )
      ]),
    );
  }
}
