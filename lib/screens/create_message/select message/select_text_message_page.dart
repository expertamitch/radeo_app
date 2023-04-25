import 'dart:io';

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../../assets/images.dart';
import '../../../styling/app_colors.dart';
import '../../../widgets/app_text.dart';

class SelectTextMessagePage extends StatefulWidget {
  const SelectTextMessagePage({Key? key}) : super(key: key);

  @override
  State<SelectTextMessagePage> createState() => _SelectTextMessagePageState();
}

class _SelectTextMessagePageState extends State<SelectTextMessagePage> {
  late TextEditingController controller;
  late List<String> textMessagesList;
  @override
  void initState() {
    super.initState();
    textMessagesList = ['dummy text 1', 'dummy text 2', 'dummy text 3'];
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 65),
          child: SafeArea(
              child: Container(
            decoration: const BoxDecoration(
              color: AppColors.darkGreyColor,
            ),
            alignment: Alignment.center,
            child: AnimationSearchBar(
                backIconColor: Colors.black,
                centerTitle: 'Select Text',
                backIcon: Platform.isAndroid ? Icons.arrow_back_outlined : null,
                onChanged: (text) {
                  textMessagesList = textMessagesList
                      .where(
                          (e) => e.toLowerCase().contains(text.toLowerCase()))
                      .toList();
                  setState(() {});
                },
                searchTextEditingController: controller,
                horizontalPadding: 5),
          ))),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageView(
                path: Images.textFileIcon,
                height: 16,
                color: AppColors.purpleColor,
              ),
              SizedBox(
                width: 10,
              ),
              AppText(
                text: 'Create Message',
                textSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.purpleColor,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: AppColors.greyColor,
            thickness: 1,
          )
        ],
      )),
    );
  }
}
